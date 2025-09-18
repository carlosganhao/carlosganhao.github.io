<script>
    import CssLogo from "../../icons/tech/CSSLogo.svelte";
    import HtmlLogo from "../../icons/tech/HTMLLogo.svelte";
    import JavascriptLogo from "../../icons/tech/JavascriptLogo.svelte";
    import MadeWith from "../../partials/MadeWith.svelte";
    import ProjectPage from "../../partials/ProjectPage.svelte";

    let {onClick, handleAnchor} = $props()
    export const path = "/experiments/rockpaperscissors"
    const backHref = path.substring(0, path.lastIndexOf('/'));
</script>

<ProjectPage title={"P2P Rock, Paper, Scissors"} {backHref} {handleAnchor} imageContent={null} class={"grid-cols-1"}>
    {#snippet textContent()}
        <MadeWith>
            <HtmlLogo/>
            <CssLogo/>
            <JavascriptLogo/>
        </MadeWith>
        <p class="mb-3">
            This is a little page on Github Pages that I created with the intent of answering one question: "Can I create a multiplayer browser game without a server?"
        </p>
        <p class="mb-3">
            First I had to choose the game, the simpler the better. So I ended up choosing the age old game of "Rock, Paper, Scissors".
            Then I had to figure out a way to connect players to one another, only through client-side javascript. Ended up finding this library called "Peer.js"
            that is able to create simple Peer-to-Peer connections. For hosting I went with Github Pages
        </p>
        <p class="mb-3">
            The end result was a playable, albeit clunky, Rock Paper Scissors game in the browser, needing the players to only have to exchange their connection key.
        </p>
        <p class="mb-3">
            The results where mixed. In a sense it is possible to create a multiplayer browser game without a server, but only as I'm not the one owning the server.
            Both Github Pages and Peer JS have their own servers that this projects runs off of.
        </p>
        <a class="link" href="https://carlosganhao.github.io/JsServerlessGame-PoC/">Check it out here</a>
    {/snippet}
</ProjectPage>