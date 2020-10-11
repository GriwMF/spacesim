import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

const debug = process.env.NODE_ENV !== 'production'

export default new Vuex.Store({
  state: {
    histories: INITIAL_STATE,
    currentFilter: 'All'
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
      state.histories = [...state.histories, JSON.parse(histories)]
    },
    setFilter (state, filter) {
      state.currentFilter = filter
    }
  },
  strict: debug,
})
