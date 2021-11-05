<template>
  <div>
<!--    {{systemData.name}}  -->
    <img :src="`assets/ships/systems/${systemData.name}.png`" :alt="systemData.name">
    <div class="system-hp" :style="elemColors(systemData.integrity)"></div>
  </div>
</template>

<script>
  export default {
    name: "shipSystem",
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
      }
    },
    props: ['systemData'],
  }
</script>

<style scoped>
  img {
    width: 25px;
    height: 20px;
    background-color: white;
  }

  .system-hp {
    width: 25px;
    height: 5px;
  }
</style>
