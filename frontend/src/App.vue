<template>
  <div>
    <Header />
    <article class="h-main p-3 bg-gray-100">
      <router-view />
    </article>
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
.bg-gold-500,
.hover\:bg-gold-500:hover {
  background-color: theme('colors.gold.default');
}
.bg-silver-500,
.hover\:bg-silver-500:hover {
  background-color: theme('colors.silver.default');
}
.border-gold-500 {
  border-color: theme('colors.gold.default');
}
.border-silver-500 {
  border-color: theme('colors.silver.default');
}
.h-main {
  min-height: calc(100vh - 48px - 64px);
  margin-bottom: 64px;
}
.text-gold-500,
.hover\:text-gold-500:hover,
.focus\:text-gold-500:focus {
  color: theme('colors.gold.default');
}
.text-silver-500,
.hover\:text-silver-500:hover,
.focus\:text-silver-500:focus {
  color: theme('colors.silver.default');
}
</style>
