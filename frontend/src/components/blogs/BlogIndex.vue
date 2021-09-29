<template>
  <section class="w-full h-full bg-white shadow-md relative p-3 mx-auto">
    <BlogCards
      :blogs="blogs"
      @touchstart="swipe.slideStart($event)"
      @touchmove="slideMove"
      @touchend="swipe.slideEnd()"
    />
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
    slideMove(...args){
      if(this.swipe.slideMove(args[0])){ // touchEvent
        this.blogs.delete(args[1]) // blog.id
        this.swipe.flag = false;
      }
    },
  }
}
</script>

<style>
.slide-fade-enter-active {
  transition: all .2s ease;
}
.slide-fade-leave-active {
  transition: all .5s cubic-bezier(1.0, 0.5, 0.8, 1.0);
}
.slide-fade-enter, .slide-fade-leave-to {
  transform: translateX(-20px);
  opacity: 0;
}
.slider {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
.slider::-webkit-scrollbar {
  display:none;
}
</style>
