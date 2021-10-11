<template>
  <section class="w-full h-full overflow-scroll bg-white shadow-md relative p-3 mx-auto">
    <BlogIndexHeader
      @getBlogs="getBlogs"
      @getStars="getStars"
      @getHigherRating="getHigherRating"
      :currentBlogs="currentBlogs"
    />
    <BlogCards
      v-if="blogs.items.length > 0"
      :blogs="blogs"
      :user="user"
      @touchstart="swipe.slideStart($event)"
      @touchmove="slideMove"
      @touchend="swipe.slideEnd()"
    />
    <p v-else class="text-silver-500 text-center py-4">{{ $t("errors.no_posts_message") }}</p>
    <FlashMessageView
      :hook="flashMessage.is_displayed"
      :message="flashMessage.content"
    />
  </section>
</template>

<script>
import axios            from 'axios'
import Blogs            from '../../models/blog/blogs.js'
import BlogCards        from './BlogCard.vue'
import BlogIndexHeader  from './BlogIndexHeader.vue'
import FlashMessage     from '../../models/flashMessage.js'
import FlashMessageView from '../shared/FlashMessage.vue'
import Swipe            from '../../models/swipe.js'
export default {
  data(){
    return {
      blogs: new Blogs(),
      swipe: new Swipe(),
      flashMessage: new FlashMessage(),
      currentBlogs: 'latest'
    }
  },
  props: {
    user: {
      id: Number
    }
  },
  components: {
    BlogCards,
    BlogIndexHeader,
    FlashMessageView,
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
          this.currentBlogs = 'latest'
        })
        .catch(error => {
          console.log(response.data)
        })
    },
    getStars() {
      axios
        .get('http://localhost:3000/api/v1/my_blogs/0/index_my_stars')
        .then(response => {
          this.blogs.set(response.data)
          this.currentBlogs = 'stars'
        })
        .catch(error => {
          console.log(response.data)
        })
    },
    getHigherRating() {
      axios
        .get('http://localhost:3000/api/v1/my_blogs/0/index_higher_rating')
        .then(response => {
          this.blogs.set(response.data)
          this.currentBlogs = 'higher_rating'
        })
        .catch(error => {
          console.log(response.data)
        })
    },
    slideMove(...args){ // [0]touchEvent, [1]blog
      const blog = args[1]
      if(this.swipe.slideMove(args[0])){
        if(this.user.id === blog.user_id){
          this.jumpToBlogEdit(blog.url)
          this.blogs.delete(blog.id)
        } else {
          if(!blog.is_liked){
            this.createStar(blog.url, blog.id)
          }
        }
        this.swipe.flag = false;
      }
    },
    createStar(url, id){
      axios
        .post(`http://localhost:3000/api/v1/stars?url=${url}`)
        .then(response => {
          this.blogs.delete(id)
          this.flashMessage.display(this.$t("form.starred"))
        })
        .catch(error => {
          console.log(error.response.data)
          this.flashMessage.display(this.$t("errors.can_not_star"))
        })
    },
    jumpToBlogEdit(url){
      this.$router.push({
        name: 'blog_edit',
        params: {
          url: url 
        }
      })
    }
  }
}
</script>
