<script>
    import Header from "../../partials/Header.svelte";
    import List from "../../partials/List.svelte";

    let { onClick, handleAnchor } = $props();
    export const path = "/gamedev";
</script>

<div class="root">
    <Header title={"Gamedev"} {handleAnchor}/>
    <div class="body">
        <List title="Games Made:">
            <a class="link text-xl pl-2" href="/gamedev/choppingwood" onclick={handleAnchor}>Chopping Wood</a>
        </List>
        <List title="Jams Participated:">
            <a class="link text-xl pl-2" href="/gamedev/gmtk" onclick={handleAnchor}>GMTK</a>
            <a class="link text-xl pl-2" href="/gamedev/acerolajam" onclick={handleAnchor}>Acerola Jam</a>
            <a class="link text-xl pl-2" href="/gamedev/piratejam" onclick={handleAnchor}>Pirate Jam</a>
        </List>
    </div>
    <div class="flex mx-12 mb-5">
        <a class="link-btn" href="/" onclick={handleAnchor}>Back</a>
    </div>
</div>
