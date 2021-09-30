<template>
  <header class="w-full mb-4 pb-4 border-b">
    <img :src="coverUrl" alt="" class="h-32 w-full object-cover object-center mb-4 shadow-lg">
    <h1 class="font-bold text-xl mb-2">{{ blog.subject }}</h1>
    <div class="flex items-center ml-2 mb-2">
      <img :src="pictureUrl" alt="" class="h-10 w-10 rounded-full mr-4">
      <h2>{{ blog.user_name }}</h2>
    </div>
    <p class="text-silver-500 text-right text-sm mr-2">最終更新日: {{ blog.created_at }}</p>
  </header>
</template>

<script>
import default_cover_image  from '../../assets/dummy-header.jpg'
import default_user_picture from '../../assets/profile_default.png'
export default {
  data(){
    return {
      default_cover_image,
      default_user_picture,
    }
  },
  props: {
    blog: {}
  },
  computed: {
    coverUrl(){
      return this.blog.cover_image ? this.blog.cover_image : this.default_cover_image
    },
    pictureUrl(){
      return this.blog.user_picture ? this.blog.user_picture : this.default_user_picture
    }
  }
}
</script>
