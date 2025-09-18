<script>
    import { T } from "@threlte/core";
    import { useGltf } from "@threlte/extras";
    import { animate, eases, stagger } from "animejs";
    import { Quaternion, Vector3 } from "three";
    import { MathUtils, randInt } from "three/src/math/MathUtils.js";

    let { shardCount=64, radius = 20, shardScale = 1, rotationVelocity = [1, 1, 0], rotationDuration = 60000, ref = $bindable(), ...props } = $props();

    function generateFibonacciSphere(n) {
        const result = [];

        for (let i = 0; i < n; i++) {
            let position = new Vector3();
            let rotation = new Quaternion();
            const phi = Math.acos(-1 + (2 * i) / (n - 1));
            const theta = Math.sqrt(n * Math.PI) * phi;

            position.setFromSphericalCoords(radius, phi, theta);
            rotation.setFromUnitVectors(
                new Vector3().copy(position).normalize(),
                new Vector3(0, 0, 1),
            );

            result.push({
                position,
                rotation,
                radius,
                phi,
                theta,
            });
        }

        return result;
    }

    const nodeSmallNames = [
        "Shard_Small_1",
        "Shard_Small_2",
        "Shard_Small_3",
        "Shard_Small_4",
        "Shard_Small_5",
        "Shard_Small_6",
        "Shard_Small_7",
        "Shard_Small_8",
        "Shard_Small_9",
        "Shard_Small_10",
        "Shard_Small_11",
        "Shard_Small_12",
        "Shard_Small_13",
        "Shard_Small_14",
        "Shard_Small_15",
        "Shard_Small_16",
    ];

    const shards = $state(generateFibonacciSphere(shardCount));

    animate(shards, {
        radius: {
            from: stagger([radius - 10, radius + 10], { from: "random" }),
            to: stagger([radius + 10, radius - 10], { from: "random" }),
        },
        duration: 6000,
        ease: eases.inOutQuad,
        loop: true,
        alternate: true,
        onBegin: (self) => {
            self.progress = MathUtils.randFloat(0, 1);
        },
        onRender: (self) => {
            for (let target of self.targets) {
                // console.log(target)
                target.position = new Vector3().setFromSphericalCoords(
                    target.radius,
                    target.phi,
                    target.theta,
                );
            }
        },
    });

    const gltf = useGltf("/small-shards.gltf");
</script>

<T.Group bind:ref dispose={false} {...props} oncreate={(ref) => {animate(ref.rotation, {
    x: {
        from: 0,
        to: Math.PI*2*rotationVelocity[0],
    },
    y: {
        from: 0,
        to: Math.PI*2*rotationVelocity[1],
    },
    z: {
        from: 0,
        to: Math.PI*2*rotationVelocity[2],
    },
    ease: 'linear',
    duration: rotationDuration,
    loop: true,
})}}>
    {#await gltf then gltf}
        {#each shards as curShard}
            <T.Mesh
                geometry={gltf.nodes[
                    nodeSmallNames[randInt(0, nodeSmallNames.length - 1)]
                ].geometry}
                material={gltf.nodes[
                    nodeSmallNames[randInt(0, nodeSmallNames.length - 1)]
                ].material}
                scale={[3.25 * shardScale, 0.95, 1.85 * shardScale]}
                position={curShard.position.toArray()}
                oncreate={(ref) => {
                    ref.lookAt(0, 0, 0);
                    ref.rotateX(99);
                }}
            />
        {/each}
    {/await}
</T.Group>
