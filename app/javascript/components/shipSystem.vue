<template>
  <div>
<!--    {{systemData.name}}-->
    <img src="https://i.pinimg.com/originals/ef/bb/5e/efbb5e3a929ed16d584e2bfb46614b70.jpg">
    <div class="system-hp" :style="elemColors(90)"></div>
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
  }

  .system-hp {
    width: 25px;
    height: 5px;
  }
</style>
