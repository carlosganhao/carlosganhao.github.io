<script>
    import Header from "../../partials/Header.svelte";
    import List from "../../partials/List.svelte";

    let {onClick, handleAnchor} = $props()
    export const path = "#experiments"
</script>

<div class="root">
    <Header title={"Experiments"} {handleAnchor}/>
    <div class="grid grid-cols-2 grow mt-9 mx-12 mb-7 gap-4">
        <List title="Experiments:">
            <a class="link text-xl pl-2" href="#experiments_rockpaperscissors" onclick={handleAnchor}>P2P Rock, Paper, Scissors</a>
        </List>
        <List title="Creative Programing:">
            <a class="link text-xl pl-2" href="#experiments_3dportfolio" onclick={handleAnchor}>This Portfolio</a>
        </List>
    </div>
    <div class="flex mx-12 mb-5 justify-between items-center">
        <a class="link-btn" href="#" onclick={handleAnchor}>Back</a>
        <p class="text-neutral-600 text-s font-extralight">Have you tried pessing 's'?</p>
    </div>
</div>
