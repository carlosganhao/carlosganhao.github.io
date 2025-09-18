<script>
    import { T, useTask } from "@threlte/core";
    import { MathUtils, Vector3 } from "three";

    let {particleCount = 64, radius = 5, pointSize = 0.5, pointColor=[1, 1, 1], pointSpeed=1} = $props();

    let positions = $state(new Float32Array(particleCount * 3))
    const radiusSq = radius ** 2
    const pointData = $state([])
    
    for(let i = 0; i < particleCount; i++)
    {
        let vector = new Vector3().randomDirection().multiplyScalar(MathUtils.randFloat(0, radius))
        positions[i * 3] = vector.x;
        positions[i * 3 + 1] = vector.y;
        positions[i * 3 + 2] = vector.z;

        pointData.push({
            velocity: new Vector3().randomDirection()
        })
    }

    useTask((dt) => {
        const newPositions = new Float32Array(particleCount * 3)
        for(let i = 0; i < particleCount; i++)
        {
            const oldPos = new Vector3(positions[i * 3], positions[i * 3 + 1], positions[i * 3 + 2]);
            let newPos = calculateNewPos(oldPos, pointData[i].velocity)
            
            while(Math.random() < MathUtils.mapLinear(newPos.lengthSq(), radiusSq/2, radiusSq, 0, 1))
            {
                pointData[i].velocity.randomDirection()
                newPos = calculateNewPos(oldPos, pointData[i].velocity)
            }

            newPositions[i * 3] = newPos.x;
            newPositions[i * 3 + 1] = newPos.y;
            newPositions[i * 3 + 2] = newPos.z;
        }
        positions = newPositions;

        function calculateNewPos(oldPos, velocity)
        {
            let velocityVec = new Vector3().copy(velocity).multiplyScalar(pointSpeed * dt)
            let newPos = new Vector3().copy(oldPos).add(velocityVec)
            return newPos
        }
    })

</script>

<T.Points>
    <T.BufferGeometry>
        <T.BufferAttribute 
            args={[positions, 3]}
            attach={({parent, ref}) => {
                parent.setAttribute('position', ref)
                parent.attributes.position.needsUpdate = true
                return () => {};
            }}
        />
    </T.BufferGeometry>
    <T.PointsMaterial size={pointSize} color={pointColor} />
</T.Points>