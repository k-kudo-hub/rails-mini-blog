<template>
  <section>
    <img v-if="user.cover" :src="user.cover" alt="" class="h-32 w-full object-cover shadow-md">
    <img v-else :src="dummy_header" alt="" class="h-32 w-full object-cover shadow-md">
    <div class="absolute h-20 w-20 rounded-full flex items-center justify-center bg-white top-20 left-3 border-4 border-white overflow-hidden">
      <img v-if="user.picture" :src="user.picture" alt="" height="60" width="60">
      <img v-else :src="logo" alt="" height="60" width="60">
    </div>
    <div class="m-8 mx-2">
      <div class="flex items-center">
        <h1 class="text-2xl mb-1 mr-3">{{ user.name }}</h1>
        <i @click="$emit('toggleEditModal')" class="fas fa-pen text-gray-500"></i>
      </div>
      <p class="mb-1">{{ user.introduce }}</p>
      <a class="text-silver-500 underline" :href="user.link" target="_blank" rel="nofollow noopener">{{ user.link }}</a>
      <p class="mt-2 mx-2">
        <a href="#" class="mr-1"><span class="font-bold mr-1">24</span>{{ $t("profile.follow") }}</a>/
        <a href="#" class="ml-1"><span class="font-bold mr-1">145</span>{{ $t("profile.follower") }}</a>
      </p>
    </div>
  </section>
</template>

<script>
import dummy_header from '../../assets/dummy-header.jpg'
import logo from '../../assets/logo.png'
export default {
  data(){
    return {
      dummy_header,
      logo,
    }
  },
  props: {
    user: { 
      id: Number,
      name: String,
      introduce: String,
      picture: String,
      cover: String,
    }
  },
}
</script>

<style>

</style>
