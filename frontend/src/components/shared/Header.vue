<template>
  <header class="h-12 w-full text-gold-500 shadow-md flex">
    <div class="w-1/6 flex justify-center items-center">
      <img :src="logo" height="30" width="30">
    </div>
    <div v-if="user.id" class="w-5/6 flex justify-end items-center">
      <p class="mr-2">{{ user.name }}</p>
      <div class="w-8 h-8 mr-2 border-2 rounded-3xl border-white overflow-hidden">
        <img v-if="user.picture_url" :src="returnPictureFullPath(user.picture_url)" height="32" width="32">
        <img v-else :src="logo" height="32" width="32">
      </div>
    </div>
    <div v-else class="w-5/6 flex justify-end items-center">
      <router-link to="/login" class="mr-2">{{ $t("session.sign_in") }}</router-link>
      <router-link to="/registration" class="mr-2">{{ $t("session.sign_up") }}</router-link>
    </div>
  </header>
</template>

<script>
import axios from 'axios'
import site_logo from '../../assets/m-logo-sk.png'
export default {
  data(){
    return {
      logo: site_logo,
    }
  },
  props: {
    user: {
      id: Number,
      name: String,
      introduce: String,
      picture: String,
      picture_url: String,
      cover: String,
    }
  },
  methods: {
    returnPictureFullPath(path){
      return 'http://localhost:3000'+path
    }
  }
}
</script>

<style>

</style>
