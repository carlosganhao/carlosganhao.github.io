<script>
    let {children, title} = $props()
</script>

<div class="flex flex-col border-neutral-100 border-l-2">
    <h5 class="text-3xl font-header uppercase text-neutral-900 bg-neutral-100 pl-2">{title}</h5>
    {@render children?.()}
</div>