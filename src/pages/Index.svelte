<script>
    import { onMount } from "svelte";
    import ItchLogo from "../icons/socials/ItchLogo.svelte";
    import { animate, createTimeline, stagger, text, utils } from "animejs";
    import { MathUtils } from "three";

    let {onClick, handleAnchor} = $props()
    export const path = ""

    const headerText = [
        "Gamedev",
        "Procedural",
        "Create",
        "Experiment",
        "Explore",
    ]
    let headerElement = null
    let writterElement = null
    let colsElement = null;

    let split = $state(null)
    let curText = $state("Portfolio")

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

        split.addEffect(({chars}) => {
            const timeline = createTimeline({
                loop: true,
                defaults: {
                    duration: (chars.length - 1) * 100
                },
                onLoop: (target) => {
                    curText = utils.randomPick(headerText)
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
    </div>
    <div bind:this={colsElement} class="grid grid-cols-3 gap-4 grow mt-7 mb-7 mx-12">
        <a class="menu-card bg-[url(/bg/gamedev.png)] bg-cover bg-top" href='#gamedev' onclick={handleAnchor}>
            <p class="menu-text">
                Gamedev
            </p>
        </a>
        <a class="menu-card bg-[url(/bg/tooling.png)] bg-cover bg-center" href='#tooldev' onclick={handleAnchor}>
            <p class="menu-text">
                Tooling
            </p>
        </a>
        <a class="menu-card bg-[url(/bg/experiments.png)] bg-center" href='#experiments' onclick={handleAnchor}>
            <p class="menu-text">
                Experiments
            </p>
        </a>
    </div>
    <p class="text-neutral-600 text-xs text-center">Portfolio made by cooli2 with svelte, threlte, tailwind & anime.js <a href="https://cooli2.itch.io/"><ItchLogo classes={"inline"}/></a></p>
</div>
