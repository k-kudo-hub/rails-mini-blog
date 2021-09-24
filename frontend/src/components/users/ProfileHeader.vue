<template>
  <section>
    <section class="h-32 w-full shadow-md">
      <img v-if="user.cover_url" @click="$emit('toggleCoverModal')" :src="user.cover_url" alt="" class="object-cover h-full w-full">
      <img v-else :src="dummy_header" @click="$emit('toggleCoverModal')" alt="" class="object-cover h-full w-full">
    </section>
    <section @click="$emit('togglePictureModal')" class="absolute h-20 w-20 rounded-full flex items-center justify-center bg-white top-20 left-3 border-4 border-white overflow-hidden">
      <img v-if="user.picture_url" :src="user.picture_url" alt="" class="h-full w-full content-cover">
      <img v-else :src="default_image" alt="" class="h-full w-full content-cover">
    </section>
    <section class="mt-10 mb-8 mx-2">
      <div class="flex items-center">
        <h1 class="text-xl mb-1 mr-3 font-bold">{{ user.name }}</h1>
        <i @click="$emit('toggleEditModal')" class="fas fa-pen text-gray-500"></i>
      </div>
      <p class="mb-1 whitespace-pre-wrap break-words">{{ user.introduce }}</p>
      <a class="text-silver-500 underline" :href="user.link" target="_blank" rel="nofollow noopener">{{ user.link }}</a>
      <p class="mt-2 mx-2">
        <a href="#" class="mr-1"><span class="font-bold mr-1">24</span>{{ $t("profile.follow") }}</a>/
        <a href="#" class="ml-1"><span class="font-bold mr-1">145</span>{{ $t("profile.follower") }}</a>
      </p>
    </section>
  </section>
</template>

<script>
import dummy_header from '../../assets/dummy-header.jpg'
import default_image from '../../assets/profile_default.png'
export default {
  data(){
    return {
      dummy_header,
      default_image,
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
