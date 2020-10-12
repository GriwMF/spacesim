<template>
  <div class="grid">
    <ul>
      <li>Ship1</li>
      <li>Ship2</li>
    </ul>

    <div>
      System 1
      System 2
    </div>

    <div>
      System info
    </div>
  </div>
</template>

<script>
export default {
  name: 'ships'
}
</script>

<style scoped>
  .grid {
    display: grid;
    grid-template-rows: 1fr 1fr;
    grid-template-columns: 1fr 1fr 3fr;
  }

  li {
    list-style-type: none;
  }
</style>
