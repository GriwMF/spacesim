<template>
  <div>
    <div class="grid" >
      <selectable-ship-element :elems="ships" :current-elem="currentShip" :select-elem="selectShip" />
      <selectable-ship-element :elems="systems" :current-elem="currentSystem" :select-elem="selectSystem" />

      <div v-html="shipInfo" class="info">
      </div>
    </div>

    <br/><br/><hr/>
    <ul v-if="currentShip">
      <li>name: {{ currentShip.name }}</li>
      <li>integrity: {{ currentShip.integrity }}</li>
      <li>credits: {{ currentShip.credits }}</li>
      <li>current_action: {{ currentShip.current_action }}</li>
    </ul>
    <br/><br/><hr/>
<!--    !!!!!!!!!!!!!!!!!!!-->
    <div class="ships-battle-view">
      <ship :ship-data="currentShip" />
<!--      <ship :ship-data="enemyShip" />-->
    </div>

    <div class="centered-wrapper">
      <div class="ships-status-popup" :class="popupClass" v-html="this.hoveredStatusHtml"></div>
    </div>

    <ul class="events">
      <li v-for="event in currentShipHistory" :key="event.id">
        {{ event.id }}
        ->
        {{ event.action_description }}
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
      console.log(this.factories);

      let cable = createConsumer('ws://localhost:3000/cable');

      cable.subscriptions.create({ channel: 'ShipChannel' }, {
        received: this.setShips
      })

      cable.subscriptions.create({ channel: 'HistoryChannel' }, {
        received: this.appendHistory
      })

      // outdated, replaced with history ^
      cable.subscriptions.create({ channel: 'JournalChannel', id: CURRENT_SHIP_ID }, {
        received: this.appendEvents
      })
    },
    methods: {
      ...mapActions(['populateShips']),
      ...mapMutations(['selectShip', 'selectSystem', 'setShips', 'appendEvents', 'appendHistory']),
    },
    computed: {
      ...mapState(['ships', 'currentShip', 'currentSystem', 'factories']),
      ...mapGetters([
        // проксирует в this.count доступ к store.state.count
        'hoveredStatusHtml',
        'enemyShip',
        'currentShipHistory',
      ]),
      popupClass() {
        return {
          'popup-active': this.hoveredStatusHtml?.length > 0,
        }
      },
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

  .centered-wrapper {
    position: absolute;
    visibility: hidden;
    /*justify-content: center;*/
    margin-left: auto;
    margin-right: auto;
    left: 0;
    right: 0;
  }

  .ships-status-popup {
    visibility: visible;
    margin: auto;
    z-index: -1;
    width: 220px;
    height: 300px;
    padding: 10px;
    /*display: flex;*/
    /*justify-content: space-around;*/
    position: relative;
    top: -300px;
    border: var(--system-active-color) 1px solid;
    /*background-color: #adb5bd;*/
    background-color: var(--popup-bg-color);
    /*visibility: hidden;*/
    opacity: 0;
    transition: opacity .3s;
  }

  .ships-status-popup.popup-active {
    opacity: 1;
  }
</style>
