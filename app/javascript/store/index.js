import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
  state: {
    histories: INITIAL_STATE,
    currentFilter: 'All',
    ships: [],
    currentShip: null,
    currentSystem: null,
  },
  getters: {
    filteredHistories: state => {
      return state.histories.slice(0).reverse().filter(h => state.currentFilter === 'All' || h.object_type === state.currentFilter);
    },

    filters: state => {
      return ['All', ...new Set(state.histories.map(history => { return history.object_type }))]
    }
  },
  mutations: {
    appendHistory (state, histories) {
      state.histories = [...state.histories, JSON.parse(histories)];
    },
    setFilter (state, filter) {
      state.currentFilter = filter;
    },
    selectShip (state, ship) {
      state.currentShip = ship;
      state.currentSystem = state.currentShip.systems[0];
    },
    selectSystem (state, system) {
      state.currentSystem = system;
    },
    setShips (state, ships) {
      state.ships = ships;

      // if (!state.ships.find(x => x.id === state.currentShip.id)) state.currentShip = ships[0];
      // if (!(state.currentShip.systems || []).find(x => x.id === state.currentSystem.id)) state.currentSystem =  state.currentShip.systems[0];
      if (state.currentShip) {
        state.currentShip = state.ships.find(x => x.id === state.currentShip.id)
        state.currentSystem = state.currentShip.systems.find(x => x.id === state.currentSystem.id)
      } else {
        state.currentShip = state.ships[0]
        state.currentSystem = state.currentShip.systems[0]
      }
    }
  },
  actions: {
    populateShips ({ commit }) {
      axios
        .get('/ship_data')
        .then(response => (commit('setShips', response.data)));
    }
  },
  strict: debug,
})
