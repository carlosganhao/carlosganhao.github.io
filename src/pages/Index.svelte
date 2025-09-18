<script>
    import { onMount } from "svelte";
    import ItchLogo from "../icons/socials/ItchLogo.svelte";
    import { animate, createTimeline, stagger, text, utils } from "animejs";
    import { MathUtils } from "three";

    let {onClick, handleAnchor} = $props()
    export const path = "/"

    const headerText = [
        "Portfolio",
        "Gamedev",
        "Procedural",
        "Create",
        "Click",
        "Experiment",
    ]
    let headerElement = null
    let writterElement = null

    let split = $state(null)
    let curText = $state(headerText[0])

    $effect(() => {
        if(curText && split?.refresh) {
            split.html = curText;
            split.refresh()
        }
    })

    onMount(() => {
        split = text.split(headerElement, {
            chars: {
                class: "bg-neutral-100 py-1 px-1.5"
            }
        })

        // const externalTimeline = createTimeline({
        //     loop: true,
        //     onBegin: (target) => {
        //         console.log("begin")
        //         split.refresh()
        //     },
        //     onLoop: (target) => {
        //         console.log("test")
        //     }
        // }).add({
        //     duration: 1000,
        // })

        split.addEffect(({chars}) => {
            const timeline = createTimeline({
                loop: true,
                defaults: {
                    duration: (chars.length - 1) * 100
                },
                onLoop: (target) => {
                    curText = headerText[MathUtils.randInt(0, headerText.length - 1)]
                }
            })
            
            timeline
            .add(chars, {
                opacity: {
                    from: 0,
                    to: 1,
                    modifier: utils.round(0),
                    duration: 100
                },
                delay: stagger(100, {from: 'first'}),
            })
            .add(writterElement, {
                opacity: [
                    {
                        from: 0,
                        duration: 0,
                    },
                    {
                        to: 1,
                        duration: 400
                    },
                    {
                        to: 0,
                        duration: 400
                    }
                ],
                duration: 400 * 5,
                modifier: utils.round(0),
                loop: 2,
            })
            .add(chars, {
                opacity: {
                    from: 1,
                    to: 0,
                    modifier: utils.round(0)
                },
                delay: stagger(100, {from: 'last'}),
            })
            .init()

            return timeline;
        })
    })
</script>

<div class="root">
    <div class="flex mt-9 mx-12 border-b-4 border-neutral-100">
        <h1 bind:this={headerElement} class="text-8xl font-header uppercase text-neutral-900 text-center">{curText}</h1>
        <span bind:this={writterElement} class={"text-8xl uppercase text-neutral-100 bg-neutral-100 py-1 px-3 opacity-0"}>_</span>
        <!-- <h5 class="text-lg font-header lowercase text-amber-50 text-center drop-shadow-md drop-shadow-coral-400/60">creative</h5> -->
    </div>
    <div class="grid grid-cols-3 grid-rows-1 gap-4 grow mt-7 mb-7 mx-12">
        <a class="link menu-card bg-azure-900" href='/gamedev' onclick={handleAnchor}>
            <p>
                Gamedev
            </p>
        </a>
        <a class="link menu-card bg-byzantium-900" href='/tooldev' onclick={handleAnchor}>
            <p>
                Tooling
            </p>
        </a>
        <a class="link menu-card bg-avocado-800" href='/experiments' onclick={handleAnchor}>
            <p>
                Experiments
            </p>
        </a>
    </div>
    <p class="text-neutral-600 text-xs text-center">Made by cooli2 with svelte, threlte, tailwind & anime.js <a href="https://cooli2.itch.io/"><ItchLogo classes={"inline"}/></a></p>
</div>
