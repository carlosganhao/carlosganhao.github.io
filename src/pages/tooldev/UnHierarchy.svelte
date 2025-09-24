<script>
    import BlenderLogo from "../../icons/tech/BlenderLogo.svelte";
    import CSharpLogo from "../../icons/tech/CSharpLogo.svelte";
    import UnityLogo from "../../icons/tech/UnityLogo.svelte";
    import MadeWith from "../../partials/MadeWith.svelte";
    import ProjectPage from "../../partials/ProjectPage.svelte";

    let {onClick, handleAnchor} = $props()
    export const path = "#tooldev_unhierarchy"
    const backHref = path.substring(0, path.lastIndexOf('_'));
</script>

<ProjectPage title={"UnHierarchy"} {backHref} {handleAnchor}>
    {#snippet textContent()}
        <MadeWith>
            <UnityLogo/>
            <CSharpLogo/>
        </MadeWith>
        <p class="mb-3">
            This tool was born over the need for more visual organization for big project on unity.
        </p>
        <p class="mb-3">
            With this addon one can decorate their unity hierarchy with things like: alternating row colors; automatic icons; layer names; and much more. It also makes it possible to add custom background color and icons to any specific hierarchy item, and any change is saved between sessions.
        </p>
        <p class="mb-3">
            Personally I dislike the default Unity hierarchy. Its just gray, and not much else. And if one would like to customize it, they need to either buy an asset or venture creating their own addon using Unity's badly documented hierarchy API's. I chose the latter.
        </p>
        <p class="mb-3">
            I created this tool not only so I could better organize my projects, but also to give anyone who wishes to do the same some structure and knowledge to do even better than what I could. If you want to fork it, go ahead!
        </p>
        <a class="link" href="https://github.com/carlosganhao/UnHierarchy">Github Page</a>
    {/snippet}
    {#snippet imageContent()}
        <img class="h-full col-span-2" alt="unhierarchy-1" src="https://github.com/carlosganhao/UnHierarchy/raw/main/GitFiles/intro.gif" />
    {/snippet}
</ProjectPage>