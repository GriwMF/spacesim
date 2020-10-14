<template>
  <div id="app">
    <router-link to="/">Go to History</router-link>
    <router-link to="/ships">Go to Ships</router-link>
    <br/>
    <a href="#" @click.prevent="pingServerGo()">Go!</a>

    <router-view></router-view>
  </div>
</template>

<script>
import History from './history'
import Ships from './ships'
export default {
  components: {Ships, History},
  methods: {
    pingServerGo: function () {
      fetch('http://localhost:3000/bc');
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
