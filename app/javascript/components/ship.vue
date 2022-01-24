<template>
  <div class="ship">
    <div v-if="shipData">
      {{ shipData.name }}
      {{ shipData.current_action }}
    </div>
    <img src="assets/ships/a.png" :style="style" @click="imgClick">
    <div class="ship-systems">
      <ship-system v-for="systemData in systemsData" :system-data="systemData" :key="systemData.id"></ship-system>
<!--      <ship-system :system-data="shipData.systems[0]"></ship-system>-->
<!--      <ship-system :system-data="shipData.systems[0]"></ship-system>-->
<!--      <ship-system :system-data="shipData.systems[0]"></ship-system>-->
<!--      <ship-system :system-data="shipData.systems[0]"></ship-system>-->
<!--      <ship-system :system-data="shipData.systems[0]"></ship-system>-->
    </div>
  </div>
</template>

<script>
  import shipSystem from './shipSystem'
  import _ from 'lodash'

  export default {
    name: "ship",
    components: { shipSystem },
    computed: {
      elemList() {
        return _.orderBy(this.elems, 'id', 'desc');
      },
      systemsData () {
        return this.shipData?.systems;
      },
      style() {
        return {
          transform: 'rotate(' + this.deg + 'deg)',
        }
      }
    },
    data() {
      return {
        deg: 60,
      }
    },
    methods: {
      // elemColors(elem) {
      //   const hpColor = '#6E1E1E';
      //   const bgColor = '#333';
      //   const integrity = elem.integrity;
      //   let color = "#7487A3";
      //
      //   if (elem == this.currentElem) color = "#d2d2d4";
      //   return {
      //     background: "linear-gradient(90deg, " + hpColor + " " + integrity + "%, " + bgColor + " " + integrity + "% " + (100 - integrity) + "%)",
      //     color
      //   }
      // },
      imgClick() {
        this.deg += 10;
      }
    },
    props: ['elems', 'currentElem', 'selectElem', 'shipData'],
  }
</script>

<style scoped>
  .ship {
    width: 200px;
  }

  .ship-systems {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 5px;
    margin-top: 25px;
  }
</style>
