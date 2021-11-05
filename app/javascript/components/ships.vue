<template>
  <div>
    <div class="grid" style="display: none">
      <selectable-ship-element :elems="ships" :current-elem="currentShip" :select-elem="selectShip" />
      <selectable-ship-element :elems="systems" :current-elem="currentSystem" :select-elem="selectSystem" />

      <div v-html="shipInfo" class="info">
      </div>
    </div>

    <br/><br/><hr/>
    <div class="ships-battle-view">
      <ship :ship-data="currentShip" />
      <ship :ship-data="currentShip" />
    </div>

    <div class="ships-status-popup" v-html="shipsStatusHtml">
      foozxx
    </div>

    <ul class="thoughts">
      <li v-for="event in events" :key="event.id">
        {{ event }}
      </li>
    </ul>

  </div>
</template>

<script>
import { mapActions, mapGetters, mapMutations, mapState } from 'vuex'
  import selectableShipElement from './selectableShipElement'
  import ship from './ship'
  import { createConsumer } from '@rails/actioncable'

  export default {
    name: 'ships',
    components: {selectableShipElement, ship},
    created() {
      this.populateShips();

      let cable = createConsumer('ws://localhost:3000/cable');

      cable.subscriptions.create({channel: 'ShipChannel'}, {
        received: this.setShips
      })

      cable.subscriptions.create({ channel: 'JournalChannel', id: CURRENT_SHIP_ID }, {
        received: this.appendEvents
      })
    },
    methods: {
      ...mapActions(['populateShips']),
      ...mapMutations(['selectShip', 'selectSystem', 'setShips', 'appendEvents']),
    },
    computed: {
      ...mapState(['ships', 'currentShip', 'currentSystem', 'events']),
      ...mapGetters([
        // проксирует в this.count доступ к store.state.count
        'shipsStatusHtml'
      ]),
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

  .ships-battle-view {
    margin: auto;
    width: 80%;
    display: flex;
    justify-content: space-around;
  }

  .ships-status-popup {
    margin: auto;
    width: 200px;
    /*display: flex;*/
    /*justify-content: space-around;*/
    position: relative;
    top: -50px;
    border: #F9425F 1px solid;
    background-color: #adb5bd;
  }
</style>
