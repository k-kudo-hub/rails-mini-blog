<template>
  <section class="w-full bg-white shadow-md relative p-5 mx-auto">
    <h1 class="mb-4">ブログ作成</h1>
    <form @submit.prevent>
      <div class="flex flex-col mb-3">
        <label for="subject" class="mb-2 flex items-center">タイトル<require-label/></label>
        <input v-model="blog.subject" ref="subject" class="border-b h-10" type="text" name="subject" :placeholder="$t('form.character_20')">
      </div>
      <div class="flex flex-col mb-3">
        <label for="body" class="mb-2 flex items-center">本文</label>
        <textarea v-model="blog.body" ref="body" class="border-b h-20" type="text" name="body"></textarea>
      </div>
      <div class="flex items-center w-3/4 justify-between mx-auto">
        <button-default
          :text="$t('form.cancel')"
        />
        <button-filled
          @click="createBlog"
          :text="$t('form.update')"
        />
      </div>
    </form>
  </section>
</template>

<script>
import axios         from 'axios'
import Blog          from '../../models/blog/blog.js'
import BlogError     from '../../models/blog/error.js'
import ButtonDefault from '../shared/ButtonDefault.vue'
import ButtonFilled  from '../shared/ButtonFilled.vue'
import RequireLabel  from '../shared/RequireLabel.vue'
export default {
  data(){
    return {
      blog: new Blog(),
    }
  },
  components: {
    ButtonDefault,
    ButtonFilled,
    RequireLabel
  },
  methods: {
    createBlog(){
      axios
        .post(`http://localhost:3000/api/v1/blogs/`, {
          blog: {
            subject: this.blog.subject,
            body: this.blog.body,
            cover_image: this.blog.cover_image,
          }
        })
        .then(response => {
          this.blog.set(response.data)
          console.log(this.blog)
        })
        .catch(error => {
          console.log(error)
        })
    }
  }
}
</script>

<style>

</style>
