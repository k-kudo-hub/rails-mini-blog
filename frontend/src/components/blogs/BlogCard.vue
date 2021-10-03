<template>
  <transition-group name="slide-fade" tag="section">
    <div
      class="w-full h-full mb-2 overflow-x-auto overflow-y-hidden whitespace-nowrap slider"
      @touchstart="$emit('touchstart', $event)"
      @touchmove="$emit('touchmove', $event, blog.id)"
      @touchend="$emit('touchend')"
      v-for="blog in blogs.items"
      :key="blog.id"
    >
      <div class="h-32 inline-block w-16/12 flex">
        <article
          :style="exportBgImage(blog.cover_image_url)" 
          class="bg-center bg-cover w-9/12 slider-center"
        >
          <div class="w-full h-full bg-black bg-opacity-50 text-white px-4 py-1 w-8/12">
            <button @click="jumpToBlogsShow(blog.url)" class="h-3/6 w-full flex items-center text-left">
              <h1 class="w-full font-bold text-lg whitespace-pre-wrap">{{ blog.subject }}</h1>
            </button>
            <div class="h-1/6">
              <p class="text-xs">{{ blog.format_created_at }}</p>
            </div>
            <div class="h-2/6 flex items-center justify-between">
              <div class="flex items-center">
                <div class="h-6 w-6 bg-white mr-2 flex items-center rounded-2xl overflow-hidden">
                  <img :src="blog.user_picture" alt="" class="h-full w-full content-cover">
                </div>
                <h2>{{ blog.user_name }}</h2>
              </div>
              <div>
                <i class="fas fa-star"></i>
              </div>
            </div>
          </div>
        </article>
        <div class="w-3/12 bg-gold-500 h-full text-white">
          <div class="h-2/3 flex items-center justify-center">
            <img class="h-12 w-12 mt-4" src="/src/assets/star.png" alt="">
          </div>
          <p class="h-1/3 text-center font-bold">STAR</p>
        </div>
      </div>
    </div>
  </transition-group>
</template>

<script>
export default {
  props: {
    blogs: {
      items: []
    }
  },
  methods: {
    exportBgImage(file){
      const path = file ? file : '/src/assets/dummy-header.jpg'
      return `background-image: url(${path})`
    },
    jumpToBlogsShow(url){
      this.$router.push({
        name: 'blog_show',
        params: {
          url: url 
        }
      })
    }
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
