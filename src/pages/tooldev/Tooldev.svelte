<script>
    import Header from "../../partials/Header.svelte";
    import List from "../../partials/List.svelte";

    let {onClick, handleAnchor} = $props()
    export const path = "/tooldev"
</script>

<div class="root">
    <Header title={"Tooling"} {handleAnchor}/>
    <div class="grid grid-cols-2 grow mt-9 mx-12 mb-7 gap-4">
        <List title="Tools Made:">
            <a class="link text-xl pl-2" href="/tooldev/unhierarchy" onclick={handleAnchor}>UnHierarchy</a>
        </List>
    </div>
    <div class="flex mx-12 mb-5">
        <a class="link-btn" href="/" onclick={handleAnchor}>Back</a>
    </div>
</div>
