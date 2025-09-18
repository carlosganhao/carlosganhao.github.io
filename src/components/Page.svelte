<script>
    import { T, useLoader } from "@threlte/core";
    import { GLTF, HTML, useGltf } from "@threlte/extras";
    import { GLTFLoader } from "three/examples/jsm/Addons.js";
    import Basic from "./basic.svelte";
    import Shard from "./Shard.svelte";

    let {children, sprites, ...props} = $props();
</script>

<T.Group
  {...props}
>
  <HTML
    position={[0, 0, 0.1]}
    transform
    occlude={"blending"}
  >
    <div class="html-page-holder">
      {@render children?.()}
    </div>
  </HTML>
  <!-- <T.Mesh>
    <T.BoxGeometry args={[32.5, 18.5, 0.1]} />
    <T.MeshStandardMaterial color="#11226F" />
  </T.Mesh> -->
  <!-- {#await useGltf("/basic.gltf") then gltf}
    <T
      is={gltf.scene}
    />
  {/await} -->
  <Shard fallback={null} error={null} children={null}></Shard>
  {@render sprites?.()}
</T.Group>

<style>
  .html-page-holder {
    width: 1280px;
    height: 720px;
    backface-visibility: hidden;
    background-color: black;
  }
</style>