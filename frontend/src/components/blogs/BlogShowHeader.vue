<template>
  <header class="w-full mb-4 pb-4 border-b">
    <img :src="coverUrl" alt="" class="h-32 w-full object-cover object-center mb-4 shadow-lg">
    <h1 class="font-bold text-xl mb-2">{{ blog.subject }}</h1>
    <div class="flex items-center justify-between mx-2 mb-2">
      <div class="flex items-center w-8/12">
        <img :src="pictureUrl" alt="" class="h-10 w-10 rounded-full mr-4">
        <h2>{{ blog.user_name }}</h2>
      </div>
      <div v-if="user.id === blog.user_id" class="flex items-center w-4/12 justify-end">
        <button @click="jumpToBlogEdit" class="text-silver-500 mr-4">
          <i class="fas fa-pen"></i>
        </button>
        <button @click="deleteBlog" class="text-silver-500">
          <i class="fas fa-trash-alt"></i>
        </button>
      </div>
    </div>
    <p class="text-silver-500 text-right text-sm mr-2">{{ $t('common.updated_at') }}: {{ blog.updated_at }}</p>
  </header>
</template>

<script>
import axios from 'axios'
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
    blog: {},
    user: {
      id: Number
    }
  },
  computed: {
    coverUrl(){
      return this.blog.cover_image ? this.blog.cover_image : this.default_cover_image
    },
    pictureUrl(){
      return this.blog.user_picture ? this.blog.user_picture : this.default_user_picture
    },
    jumpToBlogEdit(){
      this.$router.push({
        name: 'blog_edit',
        params: {
          url: this.blog.url
        }
      })
    },
    deleteBlog(){
      if(confirm(`「${this.blog.subject}」${this.$t('form.delete_message')}`)){
        axios
          .delete(`http://localhost:3000/api/v1/blogs/${this.blog.url}`)
          .then(response => {
            this.$router.push({
              path: '/'
            })
          })
          .catch(error => {
            console.log(error.response.data)
          })
      }
    }
  }
}
</script>
