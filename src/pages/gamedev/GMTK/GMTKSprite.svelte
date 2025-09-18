<script>
    import { T } from "@threlte/core";
    import { AnimatedSpriteMaterial } from "@threlte/extras";

</script>

<!-- GMTK2023 -->
<T.Mesh
    position={[-16.1, 4, 0.25]}
>
    <T.PlaneGeometry args={[1.4, 1.8]} />
    <AnimatedSpriteMaterial
        textureUrl={"/sprites/gmtk/jane.png"}
        totalFrames={1}
    />
</T.Mesh>

<!-- GMTK2024 -->
<T.Group
    position={[16.2, -2, 0.25]}
>
    {#each { length: 8 } as letter, index}
        <T.Mesh
            position={[0, 1.6 * index, 0]}
        >
            <T.PlaneGeometry args={[1.6, 1.6]} />
            <AnimatedSpriteMaterial
                textureUrl={"/sprites/gmtk/letters-blue.png"}
                totalFrames={16}
                rows={4}
                columns={4}
                startFrame={index}
                fps={2}
            />
        </T.Mesh>
    {/each}
</T.Group>

<!-- GMTK2025 -->
<T.Mesh
    position={[0, -9, 0.25]}
    rotation={[0, 0, -Math.PI/2]}
>
    <T.PlaneGeometry args={[3.2, 12.8]} />
    <AnimatedSpriteMaterial
        textureUrl={"/sprites/gmtk/big-sword.png"}
        totalFrames={1}
    />
</T.Mesh>