<script>
    import BlenderLogo from "../../icons/tech/BlenderLogo.svelte";
    import CSharpLogo from "../../icons/tech/CSharpLogo.svelte";
    import UnityLogo from "../../icons/tech/UnityLogo.svelte";
    import Body from "../../partials/Body.svelte";
    import MadeWith from "../../partials/MadeWith.svelte";
    import MultiPage from "../../partials/MultiPage.svelte";

    let {onClick, handleAnchor} = $props()
    export const path = "/gamedev/acerolajam"
    const backHref = path.substring(0, path.lastIndexOf('/'));
    let pages = [
        {
            title: "0",
            content: monsterwithin,
            creds: []
        },
    ]
</script>

{#snippet monsterwithin(ref)}
    <Body classes="mx-0 px-12 shrink-0 w-full snap-center mt-3" {ref}>
        {#snippet textContent()}
            <h3 class="font-header uppercase text-3xl mb-1.5">
                Monster Within
            </h3>
            <MadeWith>
                <UnityLogo/>
                <CSharpLogo/>
                <BlenderLogo/>
            </MadeWith>
            <p class="mb-3">
                For the "Aberration" theme and to experiment with 3D game development, I decided to make a horror game where the character the player controls, after a while, turns on the player and becomes the main antagonist.
            </p>
            <p class="mb-3">
                Sadly I ended up wanting to make too much for this game. That added to the difficulty of 3D caused the end product to be stripped of a bunch of planned features, and quite lacking. Althou, despite the unfinished result, I still enjoyed learning new things, and working on the game.
            </p> 
            <a class="link" href="https://cooli2.itch.io/monster-within">Itch.io Page</a>
        {/snippet}
        {#snippet imageContent()}
            <img class="h-full col-span-2" alt="monster-within-1" src="https://img.itch.zone/aW1nLzE1Mzc3OTY4LnBuZw==/347x500/ZI%2BJro.png" />
        {/snippet}
    </Body>
{/snippet}

<MultiPage title={"Acerola Jam"} {handleAnchor} {backHref} pages={pages}/>


