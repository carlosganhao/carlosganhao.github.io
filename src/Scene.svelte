<script>
    import { T, useTask, useThrelte } from "@threlte/core";
    import { OrbitControls, HTML } from "@threlte/extras";
    import { CSS2DRenderer } from "three/addons/renderers/CSS2DRenderer.js";
    import { Vector3, MathUtils, Quaternion, CurvePath, Fog, Points, BufferGeometry, SphereGeometry, Sphere, Mesh, MeshBasicMaterial, PlaneGeometry, DoubleSide } from "three";
    import OverlayDOMObject from "./components/OverlayDOMObject.svelte";
    import CounterLabel from "./components/CounterLabel.svelte";
    import Page from "./components/Page.svelte";
    import { animate, eases, createTimeline } from "animejs";
    import url from "./hooks/urlStore";
    import SmallShardFragments from "./components/SmallShardFragments.svelte";
    import PointCould from "./components/PointCould.svelte";
    import CenterCore from "./components/CenterCore.svelte";
    import { EffectComposer } from "threlte-postprocessing"
    import { BloomEffect, GodRaysEffect } from "threlte-postprocessing/effects"

    // Index Page
    import Index from "./pages/Index.svelte";
    // Gamedev Pages
    import Gamedev from "./pages/gamedev/Gamedev.svelte";
    import Gmtk from "./pages/gamedev/GMTK/GMTK.svelte";
    import GmtkSprite from "./pages/gamedev/GMTK/GMTKSprite.svelte";
    import AcerolaJam from "./pages/gamedev/AcerolaJam.svelte";
    import PirateJam from "./pages/gamedev/PirateJam/PirateJam.svelte";
    import PirateJamSprite from "./pages/gamedev/PirateJam/PirateJamSprite.svelte";
    import ChoppingWood from "./pages/gamedev/ChoppingWood/ChoppingWood.svelte";
    import ChoppingWoodSprite from "./pages/gamedev/ChoppingWood/ChoppingWoodSprite.svelte";
    // Tooling Pages
    import Tooldev from "./pages/tooldev/Tooldev.svelte";
    import UnHierarchy from "./pages/tooldev/UnHierarchy.svelte";
    // Experiment Pages
    import Experiments from "./pages/experiments/Experiments.svelte";
    import RockPaperScissors from "./pages/experiments/RockPaperScissors.svelte";
    import Portfolio from "./pages/experiments/Portfolio.svelte";
    import FloorTiles from "./components/FloorTiles.svelte";
    import { PI } from "three/src/nodes/TSL.js";

    function fibonacci_sphere(n) {
        const points = [];
        const phi = Math.PI * (Math.sqrt(5) - 1);

        for (let i = 0; i < n; i++) {
            let y = 1 - (i / (n - 1)) * 2;
            let radius = Math.sqrt(1 - y * y);

            let theta = phi * i;
            let x = Math.cos(theta) * radius;
            let z = Math.sin(theta) * radius;

            points.push(new Vector3(x, y, z));
        }

        return points;
    }

    function cameraPosToPage(pageContent) {
        const cameraPos = new Vector3();
        cameraPos.copy(pageContent.position).addScalar(defaultCameraSpacing);
        return cameraPos;
    }

    let { overlayElement } = $props();
    let deltaTime;
    const { scene, size, autoRenderTask, camera } = useThrelte();
    scene.fog = new Fog(0x242424, 300, 500)

    // Set up the CSS2DRenderer to run in a div placed atop the <Canvas>
    const overlayRenderer = new CSS2DRenderer({ element: overlayElement });

    $effect(() => {
        overlayRenderer.setSize($size.width, $size.height);
    });

    $effect(() => {
        if(!allowOrbitalControls){
            console.log("Set Look At")
            cameraState.ref.lookAt(0, 0, 0)
        }
    })

    // We are running two renderers, and don't want to run
    // updateMatrixWorld twice; tell the renderers that we'll handle
    // it manually.
    // https://threejs.org/docs/#api/en/core/Object3D.updateWorldMatrix
    scene.matrixWorldAutoUpdate = false;

    // To update the matrices *once* per frame, we'll use a task that is added
    // right before the autoRenderTask. This way, we can be sure that the
    // matrices are updated before the renderers run.
    useTask(
        (delta) => {
            deltaTime = delta;
            scene.updateMatrixWorld();
        },
        { before: autoRenderTask },
    );

    // The CSS2DRenderer needs to be updated after the autoRenderTask, so we
    // add a task that runs after it.
    useTask(
        () => {
            // Update the DOM
            overlayRenderer.render(scene, camera.current);
        },
        {
            after: autoRenderTask,
            autoInvalidate: false,
        },
    );

    const params = [
        {
            color: "#4F6FF6",
            label: "Hello",
            position: [-1, 2, 1],
        },
        {
            color: "#6FF64F",
            label: "CSS",
            position: [1, 2, 1],
        },
        {
            color: "#F64F6F",
            label: "Renderer",
            position: [1, 2, -1],
        },
    ];

    // const sun = new Mesh(new SphereGeometry(10), new MeshBasicMaterial())
    const pageCircleRadius = 60;
    const defaultCameraSpacing = 30;
    const cameraPanOutDistance = 30;
    const cameraRouteSpeed = 18;

    let allowOrbitalControls = $state(false);
    let selectedPage = $state(0);

    const content = $state([
        {
            page: Index,
            position: null,
            phi: null,
            theta: null,
            radius: null,
            rotation: null,
        },
        {
            page: Gamedev,
            position: null,
        },
        {
            page: ChoppingWood,
            sprite: ChoppingWoodSprite,
            position: null,
        },
        {
            page: Gmtk,
            sprite: GmtkSprite,
            position: null,
        },
        {
            page: AcerolaJam,
            position: null,
        },
        {
            page: PirateJam,
            sprite: PirateJamSprite,
            position: null,
        },
        {
            page: Tooldev,
            position: null,
        },
        {
            page: UnHierarchy,
            position: null,
        },
        {
            page: Experiments,
            position: null,
        },
        {
            page: RockPaperScissors,
            position: null,
        },
        {
            page: Portfolio,
            position: null,
        },
    ]);
    const cameraState = $state({
        spacing: defaultCameraSpacing,
        radius: null,
        phi: null,
        theta: null,
        damp: 3,
        ref: null,
    });

    for (let i = 0; i < content.length; i++) {
        // curPos.setFromSphericalCoords(
        //     MathUtils.randFloat(30, 50),
        //     MathUtils.randFloat(0, 2 * Math.PI),
        //     MathUtils.randFloat(0, 2 * Math.PI),
        // );
        let curPos = new Vector3();
        let curRot = new Quaternion();
        const phi = Math.acos(-1 + (2 * i) / (content.length - 1));
        const theta = Math.sqrt(content.length * Math.PI) * phi;
        const radius = pageCircleRadius;

        curPos.setFromSphericalCoords(radius, phi, theta);

        content[i].position = curPos;
        content[i].phi = phi;
        content[i].theta = theta;
        content[i].radius = radius;
        content[i].rotation = curRot.setFromUnitVectors(
            new Vector3().copy(curPos).normalize(),
            new Vector3(0, 0, 1),
        );

        content[i].animation = animate(content[i], {
            radius: {
                from: radius - 5,
                to: radius + 5,
            },
            duration: 10000,
            ease: eases.inOutQuad,
            loop: true,
            alternate: true,
            onRender: (self) => {
                content[i].position = new Vector3().setFromSphericalCoords(
                    content[i].radius,
                    content[i].phi,
                    content[i].theta,
                );
                if (i == selectedPage) {
                    const curRadius = MathUtils.damp(
                        cameraState.radius,
                        content[i].radius,
                        cameraState.damp,
                        deltaTime,
                    );
                    cameraState.radius = curRadius;
                }
            },
        });
        content[i].animation.progress = MathUtils.randFloat(0, 1);
    }

    cameraState.radius = content[selectedPage].radius;
    cameraState.phi = content[selectedPage].phi;
    cameraState.theta = content[selectedPage].theta;

    let freeCamPos = new Vector3(0, 0, 60);

    function calcCameraDesiredPosition()
    {
        const cameraPos = new Vector3();
        cameraPos.setFromSphericalCoords(
            cameraState.radius + cameraState.spacing,
            cameraState.phi,
            cameraState.theta,
        );
        return cameraPos;
    }

    let cameraDesiredPosition = $derived.by(calcCameraDesiredPosition);

    function routeToPage(index) {
        if(selectedPage == index) return;
        selectedPage = index;
        const curPage = content[selectedPage];
        const speed = cameraRouteSpeed;
        const duration =
            (cameraDesiredPosition.distanceTo(curPage.position) / speed) * 1000;
        animate(cameraState, {
            phi: curPage.phi,
            theta: curPage.theta,
            damp: {
                from: 0,
                to: 3,
            },
            duration: duration,
            ease: eases.inOutQuad,
            onRender: (self) => {
                cameraState.ref.lookAt(0, 0, 0);
            },
        });
        animate(cameraState, {
            spacing: {
                from: defaultCameraSpacing,
                to: defaultCameraSpacing + cameraPanOutDistance,
            },
            duration: duration / 2,
            loop: 1,
            alternate: true,
            ease: eases.inOutQuad,
        });
    }

    function handleAnchor(e) {
        e.preventDefault();
        const href = e.target.href;
        history.pushState(href, "", href);
    }

    url.subscribe((url) => {
        const index = content.findIndex((x) => x.instance?.path == url.pathname);
        if (index == null || index == -1) {
            console.error("No page with path", url.pathname, "found")
            return
        }
        routeToPage(index);
    })
</script>

<svelte:document
    onkeypress={(e) => {
        console.log(`Key ${e.key}`)
        if(e.key == 's') {
            allowOrbitalControls = !allowOrbitalControls
            freeCamPos = calcCameraDesiredPosition()
        }
    }}
/>

<!-- position={cameraDesiredPosition.toArray()} -->
<EffectComposer>
    <BloomEffect intensity={0.5}/>
    <!-- <GodRaysEffect sun={sun} /> -->
</EffectComposer>

<T.PerspectiveCamera
    makeDefault
    bind:ref={cameraState.ref}
    position={allowOrbitalControls ? freeCamPos.toArray() : cameraDesiredPosition.toArray()}
    oncreate={(ref) => {
        ref.lookAt(0, 0, 0);
    }}
>
    {#if allowOrbitalControls}
        <OrbitControls enableDamping maxDistance={pageCircleRadius + defaultCameraSpacing + cameraPanOutDistance + 75} />
    {/if}
</T.PerspectiveCamera>

<T.PointLight position={[0, 0, 0]} intensity={2000}/>

<!-- <T.Mesh position.y={1}>
  <T.BoxGeometry args={[2, 2, 2]} />
  <T.MeshStandardMaterial color="#F64F6F" />
</T.Mesh> -->

{#each params as { color, label, position }}
    <OverlayDOMObject {position} center={[0.5, 0.5]}>
        {#snippet content()}
            <CounterLabel {label} />
        {/snippet}

        <!-- <T.Mesh>
      <T.SphereGeometry args={[0.25]} />
      <T.MeshStandardMaterial {color} />
    </T.Mesh> -->
    </OverlayDOMObject>
{/each}

<!-- <T.Group
  position={[0, 3, 0]}
>
  <HTML
    position={[0, 0, 0.055]}
    transform
    occlude
  >
    <h1>
      Hello World
    </h1>
  </HTML>
  <T.Mesh>
    <T.BoxGeometry args={[2.8, 0.7, 0.1]} />
    <T.MeshStandardMaterial color="#11226F" />
  </T.Mesh>
</T.Group> -->

<!-- <Page position={[0, 0, 0]}>
    <HeroPage />
</Page>

<Page position={[0, 0, 0]}>
    <HeroPage />
</Page> -->

{#each content as curCont, index}
    <Page
        position={curCont.position.toArray()}
        oncreate={(ref) => {
            const lookVector = new Vector3();
            lookVector.copy(ref.position).multiplyScalar(2);
            ref.lookAt(lookVector);
        }}
    >
        <!-- {@render page?.()} -->
        <curCont.page
            onClick={() => routeToPage((selectedPage + 1) % content.length)}
            {handleAnchor}
            bind:this = {curCont.instance}
        />
        {#snippet sprites()}
            <curCont.sprite />
        {/snippet}
    </Page>
{/each}

<SmallShardFragments shardScale={0.75}/>
<SmallShardFragments radius={30} shardCount={24} rotationVelocity={[0, 1, 1]} shardScale={0.5}/>
<SmallShardFragments radius={pageCircleRadius + defaultCameraSpacing + cameraPanOutDistance + 10} shardCount={24} rotationVelocity={[1, 0, 1]} rotationDuration={180000} shardScale={1.5}/>
<PointCould radius={20} particleCount={500} pointSpeed={2} />
<CenterCore />

<T.Mesh>
    <T.SphereGeometry args={[600]} />
    <T.MeshBasicMaterial color={0x242424} side={DoubleSide}/>
</T.Mesh>

<!-- <T.Mesh position={[0, -300, 0]} rotation={[Math.PI/2, 0, 0]} scale={[5000, 5000, 5000]}>
    <T.PlaneGeometry arg={[1, 1]} />
    <T.MeshStandardMaterial side={DoubleSide} />
</T.Mesh> -->
    
<FloorTiles y={-250}/>
<FloorTiles y={250}/>
<!-- <T.Mesh>
    <T.SphereGeometry args={[10]} />
    <T.MeshPhongMaterial emissiveIntensity={10} emissive={[1, 1, 1]} />
</T.Mesh> -->
