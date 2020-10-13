<template>
  <div class="grid">
    <selectable-ship-element :elems="ships" :current-elem="currentShip" :select-elem="selectShip" />
    <selectable-ship-element :elems="systems" :current-elem="currentSystem" :select-elem="selectSystem" />

    <div>
      {{ships}}
    </div>
  </div>
</template>

<script>
  import { mapActions, mapMutations, mapState } from 'vuex'
  import SelectableShipElement from './selectableShipElement'

  export default {
    name: 'ships',
    components: {SelectableShipElement},
    created() {
      this.populateShips();
    },
    methods: {
      ...mapActions(['populateShips']),
      ...mapMutations(['selectShip', 'selectSystem']),
    },
    computed: {
      ...mapState(['ships', 'currentShip', 'currentSystem']),
      systems() {
        return this.currentShip ? this.currentShip['systems'] : [];
      }
    }
  }
</script>

<style scoped>
  .grid {
    display: grid;
    grid-template-columns: 1fr 1fr 3fr;
  }


  .active {
    background: linear-gradient(90deg, #FFC0CB 50%, #00FFFF 50%);
  }
</style>
