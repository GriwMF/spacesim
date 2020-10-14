<template>
  <div>
    <history-filter/>
    <ul>
      <li v-for="history in filteredHistories" :key="history.id">
        {{ formattedHistory(history) }}
      </li>
    </ul>
  </div>
</template>

<script>
  import { mapGetters, mapMutations } from 'vuex'
  import historyFilter from './historyFilter'
  import { createConsumer } from "@rails/actioncable"


  export default {
    name: 'history',
    created () {
      let cable = createConsumer('ws://localhost:3000/cable');

      cable.subscriptions.create('HistoryChannel', {
        received: this.appendHistory
      })
    },
    components: {historyFilter},
    computed: mapGetters([
      // проксирует в this.count доступ к store.state.count
      'filteredHistories'
    ]),
    methods: {
      ...mapMutations(['appendHistory']),
      replacer: function (key, value) {
        // Фільтрація властивостей
        if (key === 'updated_at' || key === 'created_at') {
          return undefined;
        }
        return value;
      },

      formattedHistory: function (history) {
        return JSON.stringify(history, this.replacer)
      },
    }
  }
</script>

<style scoped>

</style>
