<template>
  <div>
    <ul class="menu-bar">
      <li v-for="filter in filters" :class="{selected: filter === currentFilter}" @click.prevent="setFilter(filter)">
        {{filter}}
      </li>
    </ul>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapState } from 'vuex'

export default {
  name: 'historyFilter',
  computed: {
    ...mapGetters([
      'filters'
    ]),
    ...mapState(['currentFilter']),
  },
  methods: mapMutations(['setFilter']),
}
</script>

<style scoped>

</style>
