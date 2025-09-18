<script>
  import { Canvas } from '@threlte/core'
  import Scene from './Scene.svelte'

  let overlayElement = $state();
</script>

<div id="main">
  <Canvas>
    {#if overlayElement !== undefined}
    <Scene overlayElement={overlayElement}/>
    {/if}
  </Canvas>
</div>

<div id="overlay-renderer-target" bind:this={overlayElement}></div>

<style>
  div#main {
    height: 100%;
  }
  #overlay-renderer-target {
    left: 0;
    pointer-events: none;
    position: absolute;
    top: 0;
  }
</style>
