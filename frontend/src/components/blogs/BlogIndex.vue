<template>
  <section class="w-full h-full bg-white shadow-md relative p-3 mx-auto">
    <BlogCards
      :blogs="blogs"
    />
  </section>
</template>

<script>
import axios from 'axios'
import Blogs from '../../models/blog/blogs.js'
import BlogCards from './BlogCard.vue'
export default {
  data(){
    return {
      blogs: new Blogs(),
    }
  },
  components: {
    BlogCards
  },
  created(){
    this.getBlogs()
  },
  methods: {
    getBlogs(){
      axios
        .get('http://localhost:3000/api/v1/blogs')
        .then(response => {
          this.blogs.set(response.data)
        })
        .catch(error => {
          console.log(response.data)
        })
    },
  }
}
</script>

<style>
</style>
