<script>
    let {title, handleAnchor} = $props();
</script>

<div class="flex flex-row align-baseline mt-9 mx-12">
    <a href="#" onclick={handleAnchor} class="link no-underline drop-shadow-lg hover:drop-shadow-azure-200/50 text-6xl font-header text-neutral-900 uppercase bg-neutral-100 py-1 px-3">C2</a>
    <h1 class="text-6xl uppercase py-1 px-3">{title}</h1>
</div>