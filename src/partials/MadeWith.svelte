<script>
    let {children} = $props()
</script>

<div class="flex flex-row gap-1 content-center h-9 border-b-2 border-neutral-100 mb-3">
    <h5 class="h-full font-header uppercase px-1 py-2 bg-neutral-100 text-neutral-900">Made with</h5>
    {@render children?.()}
</div>