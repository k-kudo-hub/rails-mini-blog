<template>
  <div>
    <Header />
    
  </div>
</template>

<script>
import Header from './components/shared/Header.vue'
export default {
  data(){
    return {

    }
  },
  components: {
    Header,
  },
}
</script>

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
