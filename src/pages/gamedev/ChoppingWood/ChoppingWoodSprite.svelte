<script>
    import { T } from "@threlte/core";
    import { AnimatedSpriteMaterial } from "@threlte/extras";

</script>

<T.Group
    position={[-9, -4.5, 0.25]}
    rotation={[0, 0, 0.20]}
>
    <T.Mesh
        position={[-2, 0.5, 0]}
        rotation={[0, 0, Math.PI/2-0.1]}
    >
        <T.PlaneGeometry args={[3.2, 3.2]} />
        <AnimatedSpriteMaterial
            textureUrl={"/sprites/choppingwood/enemy-animations.png"}
            totalFrames={8}
            columns={8}
            fps={12}
        />
    </T.Mesh>
    
    <T.Mesh
        position={[-1, -0.8, 0]}
        rotation={[0, 0, Math.PI/2+0.25]}
    >
        <T.PlaneGeometry args={[3.2, 3.2]} />
        <AnimatedSpriteMaterial
            textureUrl={"/sprites/choppingwood/enemy-animations.png"}
            totalFrames={8}
            columns={8}
            delay={2*1000/12}
            fps={12}
        />
    </T.Mesh>
    
    <T.Mesh
        position={[3, 0, 0]}
        rotation={[0, 0, Math.PI/2+0.25]}
    >
        <T.PlaneGeometry args={[3.2, 3.2]} />
        <AnimatedSpriteMaterial
            textureUrl={"/sprites/choppingwood/player-animations.png"}
            totalFrames={8}
            columns={8}
            fps={12}
        />
    </T.Mesh>
</T.Group>