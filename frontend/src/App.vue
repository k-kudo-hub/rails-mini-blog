<template>
  <div>
    <Header />
    <div class="h-main w-full">
      <router-view />
    </div>
    <Footer />
  </div>
</template>

<script>
import Header from './components/shared/Header.vue'
import Footer from './components/shared/Footer.vue'
export default {
  data(){
    return {

    }
  },
  components: {
    Footer,
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
.h-main {
  height: calc(100vh - 48px - 64px);
  background-color: #F0F0F0;
}
.text-gold-500 {
  color: theme('colors.gold.default');
}
.text-silver-500 {
  color: theme('colors.silver.default');
}
</style>
