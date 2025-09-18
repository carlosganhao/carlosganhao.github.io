<script>
    import { animate } from "animejs";
    import ChevLeftIcon from "../icons/ChevLeftIcon.svelte";
    import ChevRightIcon from "../icons/ChevRightIcon.svelte";
    import Footer from "./Footer.svelte";
    import Header from "./Header.svelte";

    function calcInitialState() {
        let array = [];
        for (let i = 0; i < pages.length; i++) {
            array.push({
                title: null,
                body: null,
            });
        }
        return array;
    }

    const debounce = (callback, wait) => {
        let timeoutId = null;

        return (...args) => {
            if(timeoutId == null) {
                callback.apply(null, args);
            }
            
            timeoutId = window.setTimeout(() => {
                timeoutId = window.clearTimeout(timeoutId);
            }, wait);
        };
    };

    let { handleAnchor, backHref, title, pages } = $props();
    let pageRefs = $state(calcInitialState());
    let holderRef = $state(null);
    let selectedPage = $state(0);

    function prevPage() {
        if (selectedPage - 1 < 0) return;
        animate(holderRef, {
            x: `+=4rem`,
            duration: 500,
        });
        selectedPage = Math.max(selectedPage - 1, 0);
        scrollToPage();
    }

    function nextPage() {
        if (selectedPage + 1 > pages.length - 1) return;
        animate(holderRef, {
            x: `-=4rem`,
            duration: 500,
        });
        selectedPage = Math.min(selectedPage + 1, pages.length - 1);
        scrollToPage();
    }

    function scrollToPage() {
        pageRefs[selectedPage].title.scrollIntoView();
        pageRefs[selectedPage].body.scrollIntoView();
    }

    function titleClass(i) {
        const distance = Math.abs(selectedPage - i);
        const classes = [
            "text-neutral-100 text-2xl/8",
            "text-neutral-100/66 text-xl/8",
            "text-neutral-100/33 text-lg/8",
        ];
        return classes[Math.min(distance, classes.length - 1)];
    }
</script>

<div class="root">
    <Header {title} />
    <div class="flex flex-row mx-12 mt-3 border-b-2 pb-0.5">
        <button
            class="btn size-8 p-0"
            onclick={debounce(prevPage, 450)}
            disabled={selectedPage == 0}
        >
            <ChevLeftIcon classes="tech-icon inline" />
        </button>
        <div class="flex flex-row grow overflow-clip relative">
            <div
                bind:this={holderRef}
                class="flex flex-row absolute"
                style="left: calc(50% - 27px)"
            >
                {#each pages as page, i}
                    <div
                        bind:this={pageRefs[i].title}
                        class={[
                            "shrink-0 text-center h-8 min-w-16 snap-center transition-all duration-500",
                            titleClass(i),
                        ]}
                    >
                        {page.title}
                    </div>
                {/each}
            </div>
        </div>
        <button
            class="btn size-8 p-0"
            onclick={debounce(nextPage, 450)}
            disabled={selectedPage == pages.length - 1}
        >
            <ChevRightIcon classes="tech-icon inline" />
        </button>
    </div>
    <div
        class="flex flex-row grow overflow-x-scroll no-scrollbar snap-x snap-mandatory scroll-smooth"
    >
        {#each pages as page, i}
            {@render page.content?.(pageRefs[i])}
        {/each}
    </div>
    <Footer
        {backHref}
        {handleAnchor}
        additionalCredits={pages[selectedPage].creds}
    />
</div>
