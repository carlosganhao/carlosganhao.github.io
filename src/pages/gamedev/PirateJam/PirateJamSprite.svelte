<script>
    import { T } from "@threlte/core";
    import { AnimatedSpriteMaterial } from "@threlte/extras";

</script>

<!-- PirateJam16 -->
<T.Mesh
    position={[15.5, -4, 0.25]}
>
    <T.PlaneGeometry args={[6, 10]} />
    <AnimatedSpriteMaterial
        textureUrl={"/sprites/piratejam/player-bored.png"}
        totalFrames={1}
        flipX
    />
</T.Mesh>