<script>
    import { T } from "@threlte/core";
    import { HTML } from "@threlte/extras";
    import Shard from "./Shard.svelte";

    let {children, sprites, interactable, ...props} = $props();
</script>

<T.Group
  {...props}
>
  <HTML
    position={[0, 0, 0.1]}
    transform
    occlude={"blending"}
  >
    <div class={["html-page-holder", {"pointer-events-none": !interactable}]}>
      {@render children?.()}
    </div>
  </HTML>
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