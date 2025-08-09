<script>
    import { T, useTask, useThrelte } from "@threlte/core";
    import { CSS2DRenderer } from "three/addons/renderers/CSS2DRenderer.js";

    let { element } = $props();
    const { scene, size, autoRenderTask, camera } = useThrelte();

    // Set up the CSS2DRenderer to run in a div placed atop the <Canvas>
    const cssRenderer = new CSS2DRenderer({ element });

    $effect(() => {
        cssRenderer.setSize($size.width, $size.height);
    });

    // We are running two renderers, and don't want to run
    // updateMatrixWorld twice; tell the renderers that we'll handle
    // it manually.
    // https://threejs.org/docs/#api/en/core/Object3D.updateWorldMatrix
    scene.matrixWorldAutoUpdate = false;

    // To update the matrices *once* per frame, we'll use a task that is added
    // right before the autoRenderTask. This way, we can be sure that the
    // matrices are updated before the renderers run.
    useTask(
        () => {
            scene.updateMatrixWorld();
        },
        { before: autoRenderTask },
    );

    // The CSS2DRenderer needs to be updated after the autoRenderTask, so we
    // add a task that runs after it.
    useTask(
        () => {
            // Update the DOM
            cssRenderer.render(scene, camera.current);
        },
        {
            after: autoRenderTask,
            autoInvalidate: false,
        },
    );
</script>

<T.PerspectiveCamera
    makeDefault
    position={[10, 10, 10]}
    oncreate={(ref) => {
        ref.lookAt(0, 1, 0);
    }}
/>

<T.DirectionalLight position={[0, 10, 10]} />

<T.Mesh>
    <T.BoxGeometry args={[1, 2, 1]} />
    <T.MeshStandardMaterial color="hotpink" />
</T.Mesh>
