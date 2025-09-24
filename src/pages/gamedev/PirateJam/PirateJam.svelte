<script>
    import AsepriteLogo from "../../../icons/tech/AsepriteLogo.svelte";
    import RenpyLogo from "../../../icons/tech/RenpyLogo.svelte";
    import Body from "../../../partials/Body.svelte";
    import MadeWith from "../../../partials/MadeWith.svelte";
    import MultiPage from "../../../partials/MultiPage.svelte";

    let {onClick, handleAnchor} = $props()
    export const path = "#gamedev_piratejam"
    const backHref = path.substring(0, path.lastIndexOf('_'));
    let pages = [
        {
            title: "16",
            content: swordspurpose,
            creds: []
        },
    ]
</script>

{#snippet swordspurpose(ref)}
    <Body classes="mx-0 px-12 shrink-0 w-full snap-center mt-3" {ref}>
        {#snippet textContent()}
            <h3 class="font-header uppercase text-3xl mb-1.5">
                The Sword's Purpose
            </h3>
            <MadeWith>
                <RenpyLogo/>
                <AsepriteLogo/>
            </MadeWith>
            <p class="mb-3">
                The voted theme on this one was "You are the weapon". This with the self imposed contraint of making a visual novel resulted in a game where the player, a legendary sword destined to save the world, has to deal with the fact that there no evil to destroy and learn what its true purpose and meaning are.
            </p>
            <p class="mb-3">
                I like to experiment with new things on game jams, and since I had never done a visual novel, I attempted such with this one. Ended up being a quite enjoyable experience, despite the aclimatization to renpy's narrative language.
            </p> 
            <a class="link" href="https://cooli2.itch.io/the-swords-purpose">Itch.io Page</a>
        {/snippet}
        {#snippet imageContent()}
            <img class="h-full col-span-2" alt="sword-purpose-1" src="https://img.itch.zone/aW1nLzE5NjEyNTM1LnBuZw==/315x250%23c/%2BRm8di.png" />
        {/snippet}
    </Body>
{/snippet}

<MultiPage title={"Pirate Jam"} {handleAnchor} {backHref} pages={pages}/>


