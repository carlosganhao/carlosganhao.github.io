<script>
    import SvelteLogo from "../../icons/tech/SvelteLogo.svelte";
    import TailwindLogo from "../../icons/tech/TailwindLogo.svelte";
    import ThrelteLogo from "../../icons/tech/ThrelteLogo.svelte";
    import MadeWith from "../../partials/MadeWith.svelte";
    import ProjectPage from "../../partials/ProjectPage.svelte";

    let {onClick, handleAnchor} = $props()
    export const path = "#experiments_3dportfolio"
    const backHref = path.substring(0, path.lastIndexOf('_'));
</script>

<ProjectPage title={"This Page"} {backHref} {handleAnchor}>
    {#snippet textContent()}
        <MadeWith>
            <SvelteLogo/>
            <ThrelteLogo/>
            <TailwindLogo/>
        </MadeWith>
        <p class="mb-3">
            When I decided to make a portfolio, I knew from the begining I didnt want to make a simple webpage. Web Design isn't my strong suit, 
            and its also the thing I'm the least interested about. But making new and creative things with code is very much something I love doing!
        </p>
        <p class="mb-3">
            After some deliberation the decision was to make a 3D web page, since there are so few of them out there, and using Threlte so I could have
            an excuse to test the new and improved Svelte 5! Plus I didn't feel like paying for a domain and hosting, when I can have it for free with
            Github Pages! This last part ended up adding some more fun challenges for the project, like making a "single page router".
        </p>
        <p class="mb-3">
            Overall this was just a means for me to try out something fun, and in the process ending up with a interesting portfolio. Hope you enjoy it!
        </p>
    {/snippet}
    {#snippet imageContent()}
    {/snippet}
</ProjectPage>