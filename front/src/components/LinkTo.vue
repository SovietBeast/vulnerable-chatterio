<template>
  <a :href="to"><slot></slot></a>
</template>
<script setup>
defineProps(["to"]);
</script>
<style scoped>
a {
  text-decoration: none;
  color: inherit;
}
</style>
