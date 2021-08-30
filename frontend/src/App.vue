<script setup>
// This starter template is using Vue 3 <script setup> SFCs
// Check out https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup
import HelloWorld from './components/HelloWorld.vue'
</script>

<template>
  <img alt="Vue logo" src="./assets/logo.png" />
  <HelloWorld msg="Hello Vue 3 + Vite" />
</template>

<style>
.bg-gold-500 {
  background-color: theme('colors.gold.default');
}
.bg-silver-500 {
  background-color: theme('colors.silver.default');
}
.border-gold-500 {
  border-color: theme('colors.gold.default');
}
.border-silver-500 {
  border-color: theme('colors.silver.default');
}
.text-gold-500 {
  color: theme('colors.gold.default');
}
.text-silver-500 {
  color: theme('colors.silver.default');
}
</style>
