<script>
    import { T, useTask, useThrelte } from "@threlte/core";
    import { OrbitControls } from "@threlte/extras";
    import { animate, eases } from "animejs";
    import { DoubleSide, Fog, MathUtils, Quaternion, Vector3 } from "three";
    import { CSS2DRenderer } from "three/addons/renderers/CSS2DRenderer.js";
    import { EffectComposer } from "threlte-postprocessing";
    import { BloomEffect } from "threlte-postprocessing/effects";
    import CenterCore from "./components/CenterCore.svelte";
    import Page from "./components/Page.svelte";
    import PointCould from "./components/PointCould.svelte";
    import SmallShardFragments from "./components/SmallShardFragments.svelte";
    import FloorTiles from "./components/FloorTiles.svelte";
    import url from "./hooks/urlStore";
    import { onMount } from "svelte";
    // Index Page
    import Index from "./pages/Index.svelte";
    // Gamedev Pages
    import AcerolaJam from "./pages/gamedev/AcerolaJam.svelte";
    import ChoppingWood from "./pages/gamedev/ChoppingWood/ChoppingWood.svelte";
    import ChoppingWoodSprite from "./pages/gamedev/ChoppingWood/ChoppingWoodSprite.svelte";
    import Gamedev from "./pages/gamedev/Gamedev.svelte";
    import Gmtk from "./pages/gamedev/GMTK/GMTK.svelte";
    import GmtkSprite from "./pages/gamedev/GMTK/GMTKSprite.svelte";
    import PirateJam from "./pages/gamedev/PirateJam/PirateJam.svelte";
    import PirateJamSprite from "./pages/gamedev/PirateJam/PirateJamSprite.svelte";
    // Tooling Pages
    import Tooldev from "./pages/tooldev/Tooldev.svelte";
    import UnHierarchy from "./pages/tooldev/UnHierarchy.svelte";
    // Experiment Pages
    import Experiments from "./pages/experiments/Experiments.svelte";
    import Portfolio from "./pages/experiments/Portfolio.svelte";
    import RockPaperScissors from "./pages/experiments/RockPaperScissors.svelte";

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
        if(initialized){
            cameraState.ref.lookAt(0, 0, 0)
        }
    })

    $effect(() => {
        if(!allowOrbitalControls){
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

    const pageCircleRadius = 60;
    const defaultCameraSpacing = 30;
    const cameraPanOutDistance = 30;
    const cameraRouteSpeed = 18;

    let initialized = $state(false);
    let blockPointerEvents = $state(false);
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

    // Place pages according to fibonacci sphere positioning
    for (let i = 0; i < content.length; i++) {
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
            onBegin: () => {
                blockPointerEvents = true;
            },
            onComplete: () => {
                blockPointerEvents = false;
            }
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

    function setToPage(index) {
        if(selectedPage == index) return;
        selectedPage = index;
        const curPage = content[selectedPage];

        cameraState.phi = curPage.phi
        cameraState.theta = curPage.theta
        cameraState.ref.lookAt(0, 0, 0)
    }

    function handleAnchor(e) {
        e.preventDefault();
        const href = e.target.href;
        history.pushState(href, "", href);
    }

    url.subscribe((url) => {
        if(!initialized) return;
        const index = content.findIndex((x) => x.instance?.path == url.hash);
        if (index == null || index == -1) {
            console.error("No page with path", url.hash, "found")
            return
        }
        routeToPage(index);
    })

    onMount(() => {
        initialized = true;
        const index = content.findIndex((x) => x.instance?.path == $url.hash);
        if (index == null || index == -1) {
            console.error("No page with path", $url.hash, "found on mount")
            return
        }
        setToPage(index);
    })
</script>

<svelte:document
    onkeypress={(e) => {
        if(e.key == 's') {
            allowOrbitalControls = !allowOrbitalControls
            freeCamPos = calcCameraDesiredPosition()
            blockPointerEvents = allowOrbitalControls
        }
    }}
/>

<EffectComposer>
    <BloomEffect intensity={0.5}/>
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

{#each content as curCont, index}
    <Page
        interactable={!blockPointerEvents && selectedPage == index}
        position={curCont.position.toArray()}
        oncreate={(ref) => {
            const lookVector = new Vector3();
            lookVector.copy(ref.position).multiplyScalar(2);
            ref.lookAt(lookVector);
        }}
    >
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
    
<FloorTiles y={-250}/>
<FloorTiles y={250}/>
