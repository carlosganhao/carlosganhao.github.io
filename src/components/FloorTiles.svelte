<script>
    import { T } from "@threlte/core";
    import { Instance, InstancedMesh } from "@threlte/extras";
    import { MathUtils } from "three";

    const { count = 50, y = -250, size = 25, height = 50} = $props();
</script>

<InstancedMesh limit={count*count} range={count*count}>
    <T.BoxGeometry />
    <!-- <T.ShaderMaterial
        vertexShader={vertexShader}
        fragmentShader={fragShader}
    /> -->
    <T.MeshStandardMaterial />
    {#each {length: count}, x}
        {#each {length: count}, z}
            <Instance
                position={[size*(x-count/2), y, size*(z-count/2)]}
                scale={[size, MathUtils.randInt(10, height), size]}
            />
        {/each}
    {/each}
</InstancedMesh>