<script>
    import { fade } from "svelte/transition";
    import ItchLogo from "../icons/socials/ItchLogo.svelte";

    let {backHref, handleAnchor, additionalCredits = []} = $props()
</script>

<div class="flex mx-12 mb-5 justify-between">
    <a class="link-btn" href={backHref} onclick={handleAnchor}>Back</a>
    <p class="text-neutral-600 text-xs text-center my-auto">
        by cooli2 <a href="https://cooli2.itch.io/"><ItchLogo classes={"tech-icon inline"}/></a>
        {#each additionalCredits as credit, i}
            {credit.name} {#if credit.itch != null}<a href={credit.itch}><ItchLogo classes={"tech-icon inline"}/></a>{/if}
        {/each}
    </p>
</div>