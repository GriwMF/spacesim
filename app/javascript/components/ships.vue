<template>
  <div class="grid">
    <ul>
      <li v-for="ship in ships" :class="{ active: ship == currentShip }" @click="selectShip(ship)">
        {{ship.name}}
      </li>
    </ul>

    <ul>
      <li v-for="system in systems">
        {{system.name}}
      </li>
    </ul>

    <div>
      {{ships}}
    </div>
  </div>
</template>

<script>
  import { mapActions, mapMutations, mapState } from 'vuex'

  export default {
    name: 'ships',
    created() {
      this.populateShips();
    },
    methods: {
      ...mapActions(['populateShips']),
      ...mapMutations(['selectShip'])
    },
    computed: {
      ...mapState(['ships', 'currentShip']),
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

  li {
    list-style-type: none;
  }

  .active {
    background-color: #273C5A;
  }
</style>
