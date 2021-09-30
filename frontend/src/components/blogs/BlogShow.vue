<template>
  <section class="w-full h-full overflow-scroll bg-white shadow-md relative p-3 mx-auto">
    <BlogShowHeader
      :blog="blog"
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
  </section>
</template>

<script>
import axios          from 'axios'
import Blog           from '../../models/blog/blog.js'
import BlogShowHeader from './BlogShowHeader.vue'
import BlogShowFooter from './BlogShowFooter.vue'
import BlogMarkdown   from './BlogMarkdown.vue'
import Errors         from '../../models/blog/error.js'
export default {
  data(){
    return {
      blog: new Blog(),
      errors: new Errors(),
    }
  },
  components: {
    BlogMarkdown,
    BlogShowHeader,
    BlogShowFooter
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
    }
  }
}
</script>
