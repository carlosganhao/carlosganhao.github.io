<script>
    let {textContent, imageContent, imageRows = "[320px_1fr]", imageCols = "2", classes = "", ref = $bindable({body: null})} = $props()
</script>

<div class={["body", classes]} bind:this={ref.body}>
    <div>
        {@render textContent?.()}
    </div>
    {#if imageContent}
        <div class="grid grid-rows-{imageRows} grid-cols-{imageCols} gap-3 content-between justify-items-center">
            {@render imageContent()}
        </div>
    {/if}
</div>