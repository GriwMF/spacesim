<template>
  <div class="grid">
    <selectable-ship-element :elems="ships" :current-elem="currentShip" :select-elem="selectShip" />
    <selectable-ship-element :elems="systems" :current-elem="currentSystem" :select-elem="selectSystem" />

    <div v-html="shipInfo" class="info">
    </div>
  </div>
</template>

<script>
  import { mapActions, mapMutations, mapState } from 'vuex'
  import SelectableShipElement from './selectableShipElement'
  import { createConsumer } from '@rails/actioncable'

  export default {
    name: 'ships',
    components: {SelectableShipElement},
    created() {
      this.populateShips();

      let cable = createConsumer('ws://localhost:3000/cable');

      cable.subscriptions.create('ShipChannel', {
        received: this.setShips
      })
    },
    methods: {
      ...mapActions(['populateShips']),
      ...mapMutations(['selectShip', 'selectSystem', 'setShips']),
    },
    computed: {
      ...mapState(['ships', 'currentShip', 'currentSystem']),
      systems() {
        return this.currentShip ? this.currentShip['systems'] : [];
      },
      shipInfo() {
        return Object.keys(this.currentSystem).map((s) => `${s}: ${this.currentSystem[s]}`).join('<br/>')
      }
    }
  }
</script>

<style scoped>
  .grid {
    display: grid;
    grid-template-columns: 1fr 1fr 3fr;
  }

  .info {
    padding: 0 10px;
  }
</style>
