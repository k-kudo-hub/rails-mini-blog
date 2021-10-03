<template>
  <section class="w-full h-full overflow-scroll bg-white shadow-md relative p-3 mx-auto">
    <BlogCards
      v-if="blogs.items.length > 0"
      :blogs="blogs"
      @touchstart="swipe.slideStart($event)"
      @touchmove="slideMove"
      @touchend="swipe.slideEnd()"
    />
    <p v-else class="text-silver-500 text-center py-4">{{ $t("errors.no_posts_message") }}</p>
  </section>
</template>

<script>
import axios from 'axios'
import Blogs from '../../models/blog/blogs.js'
import BlogCards from './BlogCard.vue'
import Swipe from '../../models/swipe.js'
export default {
  data(){
    return {
      blogs: new Blogs(),
      swipe: new Swipe(),
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
    slideMove(...args){ // [0]touchEvent, [1]blog 
      if(this.swipe.slideMove(args[0])){
        this.blogs.delete(args[1].id)
        this.swipe.flag = false;
      }
    },
  }
}
</script>
