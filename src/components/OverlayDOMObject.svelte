<script>
  import { CSS2DObject } from 'three/addons/renderers/CSS2DRenderer.js'
  import { T } from '@threlte/core'

  let { content, pointerEvents = false, children, ...props } = $props()

  let element = $state()
</script>

<div
  bind:this={element}
  style:pointer-events={pointerEvents ? 'auto' : 'none !important'}
  style:will-change="transform"
>
  {@render content?.()}
</div>

{#if element !== undefined}
  <T
    {...props}
    is={CSS2DObject}
    args={[element]}
  >
    {#snippet children({ ref })}
      {@render children?.({ ref })}
    {/snippet}
  </T>
{/if}