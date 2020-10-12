<template>
  <div id="app">
    <ships/>
  </div>
</template>

<script>
import History from './history'
import Ships from './ships'
export default {
  components: {Ships, History}
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
