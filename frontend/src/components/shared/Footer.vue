<template>
  <footer class="h-16 w-full shadow-md flex items-cente fixed -bottom-0 z-10 bg-white">
    <router-link :to="menu.link" v-for="menu in menus" :key="menu.icon" class="w-1/4 text-gold-500">
      <div class="h-2/3 flex items-center justify-center">
        <i :class="menu.icon" class="fas fa-2x pt-2"></i>
      </div>
      <div class="h-1/3 flex items-center justify-center">
        <p class="text-xs">{{ $t(menu.text) }}</p>
      </div>
    </router-link>
  </footer>
</template>

<script>
import menu from '../../menu.js'
export default {
  data(){
    return {
      menus: menu.blogs,
    }
  },
  methods: {
    
  }
}
</script>

<style>

</style>
