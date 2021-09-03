<template>
  <header class="h-12 w-full text-gold-500 shadow-md flex">
    <div class="w-1/6 flex justify-center items-center">
      <img :src="image.logo" height="30" width="30">
    </div>
    <div class="w-2/6 flex justify-between items-center">
      <a href="#">{{ $t("link.blog") }}</a>
      <a href="#">{{ $t("link.trend") }}</a>
    </div>
    <div v-if="auth" class="w-3/6 flex justify-end items-center">
      <p class="mr-2">hogehoge</p>
      <div class="w-8 h-8 mr-2 border-2 rounded-3xl border-gold-500">
        <img :src="image.logo" height="32" width="32">
      </div>
    </div>
    <div v-else class="w-3/6 flex justify-end items-center">
      <router-link to="/login" class="mr-2">{{ $t("session.sign_in") }}</router-link>
      <router-link to="/registration" class="mr-2">{{ $t("session.sign_up") }}</router-link>
    </div>
  </header>
</template>

<script>
import site_logo from '../../assets/m-logo-sk.png'
export default {
  data(){
    return {
      auth: false,
      image: {
        logo: site_logo,
      }
    }
  }
}
</script>

<style>

</style>
