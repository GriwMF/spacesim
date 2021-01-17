<template>
  <div>
    <div class="grid">
      <selectable-ship-element :elems="ships" :current-elem="currentShip" :select-elem="selectShip" />
      <selectable-ship-element :elems="systems" :current-elem="currentSystem" :select-elem="selectSystem" />

      <div v-html="shipInfo" class="info">
      </div>
    </div>
    <ul class="thoughts">
      <li v-for="event in events" :key="event.id">
        {{ event }}
      </li>
    </ul>
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

      cable.subscriptions.create({channel: 'ShipChannel'}, {
        received: this.setShips
      })

      cable.subscriptions.create({ channel: 'JournalChannel', id: 11 }, {
        received: this.appendEvents
      })
    },
    methods: {
      ...mapActions(['populateShips']),
      ...mapMutations(['selectShip', 'selectSystem', 'setShips', 'appendEvents']),
    },
    computed: {
      ...mapState(['ships', 'currentShip', 'currentSystem', 'events']),
      systems() {
        return this.currentShip ? this.currentShip['systems'] : [];
      },
      shipInfo() {
        if (this.currentSystem) {
          return Object.keys(this.currentSystem).map((s) => `${s}: ${this.currentSystem[s]}`).join('<br/>')
        }
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
