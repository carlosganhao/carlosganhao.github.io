<script>
    import { T } from "@threlte/core";
    import fragShader from "../shaders/fresnel_frag.glsl?raw";
    import vertexShader from "../shaders/fresnel_vert.glsl?raw";

    let {ref = $bindable()} = $props()

</script>

<T.Mesh bind:ref={ref}>
    <T.SphereGeometry args={[10]} />
    <T.ShaderMaterial
        vertexShader={vertexShader}
        fragmentShader={fragShader}
        uniforms={{
            iTime: {
                value: 0
            },
            iResolution: {
                value: [512, 512, 0]
            }
        }}
        uniforms.iTime.value={performance.now()}
    />
</T.Mesh>