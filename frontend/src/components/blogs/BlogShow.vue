<template>
  <section class="w-full h-full overflow-scroll bg-white shadow-md relative p-3 mx-auto">
    <BlogShowHeader
      @toggleStar="toggleStar"
      :blog="blog"
      :user="user"
    />
    <BlogMarkdown
      :subject="blog.subject"
      :content="blog.body"
      :display_cover="true"
      :cover_image="blog.cover_image"
    />
    <BlogShowFooter
      :user_name="blog.user_name"
      :user_picture="blog.user_picture"
      :user_introduce="blog.user_introduce"
      :user_id="blog.user_id"
    />
    <FlashMessageView
      :hook="flashMessage.is_displayed"
      :message="flashMessage.content"
    />
  </section>
</template>

<script>
import axios          from 'axios'
import Blog           from '../../models/blog/blog.js'
import BlogShowHeader from './BlogShowHeader.vue'
import BlogShowFooter from './BlogShowFooter.vue'
import BlogMarkdown   from './BlogMarkdown.vue'
import Errors         from '../../models/blog/error.js'
import FlashMessage     from '../../models/flashMessage.js'
import FlashMessageView from '../shared/FlashMessage.vue'
export default {
  data(){
    return {
      blog: new Blog(),
      errors: new Errors(),
      flashMessage: new FlashMessage(),
    }
  },
  props: {
    user: {
      id: Number,
    }
  },
  components: {
    BlogMarkdown,
    BlogShowHeader,
    BlogShowFooter,
    FlashMessageView,
  },
  created(){
    this.getBlog()
  },
  methods: {
    getBlog(){
      axios
        .get(`http://localhost:3000/api/v1/blogs/${this.$route.params['url']}`)
        .then(response => {
          this.blog.set(response.data)
          console.log(response.data)
        })
        .catch(error => {
          this.errors.catch(error.response.data)
        })
    },
    toggleStar(){
      if(this.blog.is_liked){
        this.deleteStar()
      } else {
        this.createStar()
      }
    },
    createStar(){
      axios
        .post(`http://localhost:3000/api/v1/stars?url=${this.blog.url}`)
        .then(response => {
          this.blog.toggleStar()
          this.flashMessage.display('スターしました。')
        })
        .catch(error => {
          console.log(error.response.data)
        })
    },
    deleteStar(){
      axios
        .delete(`http://localhost:3000/api/v1/stars/0?url=${this.blog.url}`)
        .then(response => {
          this.blog.toggleStar()
          this.flashMessage.display('スターを取り消しました。')
        })
        .catch(error => {
          console.log(error.response.data)
        })
    },
  }
}
</script>
