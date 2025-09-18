<script>
    import AsepriteLogo from "../../../icons/tech/AsepriteLogo.svelte";
    import CSharpLogo from "../../../icons/tech/CSharpLogo.svelte";
    import GodotLogo from "../../../icons/tech/GodotLogo.svelte";
    import UnityLogo from "../../../icons/tech/UnityLogo.svelte";
    import Body from "../../../partials/Body.svelte";
    import MadeWith from "../../../partials/MadeWith.svelte";
    import MultiPage from "../../../partials/MultiPage.svelte";

    let {onClick, handleAnchor} = $props()
    export const path = "/gamedev/gmtk"
    const backHref = path.substring(0, path.lastIndexOf('/'));
    let pages = [
        {
            title: "2023",
            content: sonofagun,
            creds: [
                {
                    name: "Whaive",
                    itch: "https://whaive.itch.io/"
                }
            ]
        },
        {
            title: "2024",
            content: cybertower,
            creds: [
                {
                    name: "Whaive",
                    itch: "https://whaive.itch.io/"
                }
            ]
        },
        {
            title: "2025",
            content: gambit,
            creds: [
                {
                    name: "Whaive",
                    itch: "https://whaive.itch.io/"
                },
                {
                    name: "Nutdealer",
                    itch: null
                }
            ]
        }
    ]
</script>

{#snippet sonofagun(ref)}
    <Body classes="mx-0 px-12 shrink-0 w-full snap-center mt-3" {ref}>
        {#snippet textContent()}
            <h3 class="font-header uppercase text-3xl mb-1.5">
                Son of a Gun
            </h3>
            <MadeWith>
                <UnityLogo/>
                <CSharpLogo/>
                <AsepriteLogo/>
            </MadeWith>
            <p class="mb-3">
                With the theme "Roles Reversed" we decided to create a game where the player plays as a gun, using the gimmick of moving only with the recoil.
            </p>
            <p class="mb-3">
                Sadly we ended up having too much scope for the 48h available and had to cut alot of the planned story elements. But still the game idea was still quite novel and fun to work on.
            </p>
            <a class="link" href="https://cooli2.itch.io/son-of-a-gun-gmtk2023">Itch.io Page</a>
        {/snippet}
        {#snippet imageContent()}
            <img class="h-full col-span-2" alt="son-of-a-gun-1" src="https://img.itch.zone/aW1nLzEyNzM3MzIzLnBuZw==/347x500/llvNZV.png" />
        {/snippet}
    </Body>
{/snippet}

{#snippet cybertower(ref)}
    <Body classes="mx-0 px-12 shrink-0 w-full snap-center mt-3" {ref}>
        {#snippet textContent()}
            <h3 class="font-header uppercase text-3xl mb-1.5">
                Cyber Tower
            </h3>
            <MadeWith>
                <UnityLogo/>
                <CSharpLogo/>
                <AsepriteLogo/>
            </MadeWith>
            <p class="mb-3">
                The theme here was "Built to Scale" and we took that to heart by making a game where one has to built a tower to get money or go bankrupt!
            </p>
            <p class="mb-3">
                The gameloop is one were the player is dealt "tower blocks" cards and then they must place them on the on going tower, considering synergies to get more money! As the height increases the cost of placing blocks increases, and the player must be sure not to go too much in the red!
            </p>
            <p class="mb-3">
                It was a really cool project we worked on for the 96h available, and that we ended up being quite pleased with!
            </p>
            <a class="link" href="https://whaive.itch.io/cyber-tower-gmtk24">Itch.io Page</a>
        {/snippet}
        {#snippet imageContent()}
            <img class="h-full col-span-2" alt="son-of-a-gun-1" src="https://img.itch.zone/aW1hZ2UvMjkxMzMzOS8xNzQyODMyMS5wbmc=/794x1000/epMaHD.png" />
        {/snippet}
    </Body>
{/snippet}

{#snippet gambit(ref)}
    <Body classes="mx-0 px-12 shrink-0 w-full snap-center mt-3" {ref}>
        {#snippet textContent()}
            <h3 class="font-header uppercase text-3xl mb-1.5">
                Gambit
            </h3>
            <MadeWith>
                <GodotLogo/>
                <CSharpLogo/>
                <AsepriteLogo/>
            </MadeWith>
            <p class="mb-3">
                In 2025 the theme was "Loop" and it was one we had quite the trouble finding an idea for. We had this trouble because we always try to make something that is different and that explores things we dont know.
            </p>
            <p class="mb-3">
                We ended up settling on a "Gamble Gladiator Game" a 2d fighting game with 2d bone animations. The player plays the roulette to decide what random enemy they will fight and with what weapon, and then they must duel in the arena.
            </p>
            <p class="mb-3">
                The process was a tough one and in the end the connection to the theme was really flimsy but at the end of the day we trying smthing completly new that was quite fun to pursue!
            </p>
            <a class="link" href="https://cooli2.itch.io/gambit">Itch.io Page</a>
        {/snippet}
        {#snippet imageContent()}
            <img class="h-full col-span-2" alt="son-of-a-gun-1" src="https://img.itch.zone/aW1hZ2UvMzc4MjIyMy8yMjUyNDgwOC5naWY=/794x1000/P9gSAQ.gif" />
        {/snippet}
    </Body>
{/snippet}

<MultiPage title={"GMTK Gamejam"} {handleAnchor} {backHref} pages={pages}/>