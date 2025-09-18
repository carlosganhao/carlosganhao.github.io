<script>
    import Body from "./Body.svelte";
    import Footer from "./Footer.svelte";
    import Header from "./Header.svelte";

    let {handleAnchor, backHref, title, textContent, imageContent, imageRows = "[320px_1fr]", imageCols = "2", additionalCredits = [], ...props} = $props()
</script>

<div class="root">
    <Header title={title} />
    <Body {textContent} {imageContent} {imageRows} {imageCols} classes={props.class} />
    <Footer {backHref} {handleAnchor} {additionalCredits} />
</div>