<script>
    import BlenderLogo from "../../../icons/tech/BlenderLogo.svelte";
    import CSharpLogo from "../../../icons/tech/CSharpLogo.svelte";
    import UnityLogo from "../../../icons/tech/UnityLogo.svelte";
    import MadeWith from "../../../partials/MadeWith.svelte";
    import ProjectPage from "../../../partials/ProjectPage.svelte";

    let {onClick, handleAnchor} = $props()
    export const path = "/gamedev/choppingwood"
    const backHref = path.substring(0, path.lastIndexOf('/'));
</script>

<ProjectPage title={"Chopping Wood"} {backHref} {handleAnchor}>
    {#snippet textContent()}
        <MadeWith>
            <UnityLogo/>
            <CSharpLogo/>
            <BlenderLogo/>
        </MadeWith>
        <p class="mb-3">
            This was my first game. What was meant to be a small and simple 6 month game, ended up being a full rework that took years.
        </p>
        <p class="mb-3">
            It is a very simple wave survival game with tower defense and roguelite mechanics. The visuals use 2d sprites made from 3d assets downresed to make high detail "pixel art".
        </p>
        <p class="mb-3">
            I wouldn't call it a good game, but it was also the game where I first experimented with random generation, compute shaders, behaviour state machines and much more.
        </p>
        <a class="link" href="https://cooli2.itch.io/chopping-wood">Itch.io Page</a>
    {/snippet}
    {#snippet imageContent()}
        <img class="h-full col-span-2" alt="chopping-wood-1" src="https://img.itch.zone/aW1hZ2UvNjgxOTY0LzE4MzkzMDY3LnBuZw==/original/h3VIEc.png" />
        <img class="h-full" alt="chopping-wood-2" src="https://img.itch.zone/aW1hZ2UvNjgxOTY0LzE4MzkzMDcwLnBuZw==/794x1000/dF9KCz.png" />
        <img class="h-full" alt="chopping-wood-3" src="https://img.itch.zone/aW1hZ2UvNjgxOTY0LzE4MzkzMDcyLnBuZw==/794x1000/sHdLEz.png" />
    {/snippet}
</ProjectPage>