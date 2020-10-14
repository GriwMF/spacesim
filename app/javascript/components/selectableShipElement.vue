<template>
  <ul>
    <li v-for="elem in elemList" :style="elemColors(elem)" @click="selectElem(elem)">
      {{elem.name}}
    </li>
  </ul>
</template>

<script>
  export default {
    name: "selectableShipElement",
    computed: {
      elemList() {
        return _.orderBy(this.elems, 'id', 'desc');
      }
    },
    methods: {
      elemColors(elem) {
        const hpColor = '#6E1E1E';
        const bgColor = '#333';
        const integrity = elem.integrity;
        let color = "#7487A3";

        if (elem == this.currentElem) color = "#d2d2d4";
        return {
          background: "linear-gradient(90deg, " + hpColor + " " + integrity + "%, " + bgColor + " " + integrity + "% " + (100 - integrity) + "%)",
          color
        }
      }
    },
    props: ['elems', 'currentElem', 'selectElem'],
  }
</script>

<style scoped>
li {
  list-style-type: none;
}
</style>
