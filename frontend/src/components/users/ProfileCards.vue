<template>
  <section class="mx-2 mb-4">
    <div class="flex justify-end items-center mr-4 mb-4">
      <h1 class="text-md w-1/3">{{ $t("profile.blogs") }}</h1>
      <div class="w-2/3 text-right flex justify-end items-center">
        <button-default
          class="mr-3"
          :text="$t('models.asset') + $t('action.manage')"
          @click="$emit('toggleAssetModal')"
        />
        <button-filled
          :text="$t('models.blog') + $t('form.create')"
          @click="jumpToBlogNew"
        />
      </div>
    </div>
    <BlogCard
      v-if="blogs.items.length > 0"
      :blogs="blogs"
      @touchstart="swipe.slideStart($event)"
      @touchmove="slideMove"
      @touchend="swipe.slideEnd()"
    />
    <p v-else class="text-silver-500 text-center py-4">まだ投稿はありません。</p>
  </section>
</template>

<script>
import logo          from '../../assets/logo.png'
import BlogCard      from '../blogs/BlogCard.vue'
import ButtonDefault from '../shared/ButtonDefault.vue'
import ButtonFilled  from '../shared/ButtonFilled.vue'
import Blogs         from '../../models/blog/blogs.js'
import Swipe         from '../../models/swipe.js'
import axios from 'axios'
export default {
  data(){
    return {
      blogs: new Blogs(),
      swipe: new Swipe()
    }
  },
  components: {
    BlogCard,
    ButtonDefault,
    ButtonFilled
  },
  created(){
    this.getBlogs()
  },
  methods: {
    getBlogs(){
      axios
        .get('http://localhost:3000/api/v1/my_blogs')
        .then(response => {
          this.blogs.set(response.data)
        })
        .catch(error => {
          console.log(response.data)
        })
    },
    slideMove(...args){ // [0]touchEvent, [1]blog.id 
      if(this.swipe.slideMove(args[0])){
        this.blogs.delete(args[1])
        this.swipe.flag = false;
      }
    },
    exportBgImage(file){
      return `background-image: url('${file}')`
    },
    jumpToBlogNew(){
      this.$router.push({
        name: 'blog_create',
      })
    },
  }
}
</script>

<style>

</style>
