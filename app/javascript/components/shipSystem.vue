<template>
  <div @mouseover="this.setPopup" @mouseleave="this.clearPopup" :class="{active}" class="outer-div">
    <img :src="`assets/ships/systems/${systemData.name}.png`" :alt="systemData.name">
    <div class="system-hp" :style="elemColors(systemData.integrity)"></div>
  </div>
</template>

<script>
  import { mapMutations } from 'vuex'

  export default {
    name: "shipSystem",
    data() {
      return { active: false };
    },
    computed: {

    },
    methods: {
      elemColors(integrity) {
        const hpColor = '#D22828FF';
        const bgColor = '#333';
        let color = "#7487A3";

        // if (elem == this.currentElem) color = "#d2d2d4";
        return {
          background: "linear-gradient(90deg, " + hpColor + " " + integrity + "%, " + bgColor + " " + integrity + "% " + (100 - integrity) + "%)",
          color
        }
      },
      setPopup() {
        this.active = true;
        this.setHoveredStatusHtml(Object.keys(this.systemData).map((s) => `${s}: ${this.systemData[s]}`).join('<br/>'));
      },
      clearPopup() {
        this.active = false;
        this.setHoveredStatusHtml('');
      },
      ...mapMutations(['setHoveredStatusHtml']),
    },
    props: ['systemData'],
  }
</script>

<style scoped>
  img {
    width: 25px;
    height: 20px;
    background-color: var(--system-bg-color);
  }

  .outer-div {
    border: 1px solid transparent;
  }

  .outer-div.active {
    border: 1px solid var(--system-active-color);
  }

  .system-hp {
    width: 25px;
    height: 5px;
  }
</style>
