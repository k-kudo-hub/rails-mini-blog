<template>
  <transition-group name="slide-fade" tag="section">
    <div
      class="w-full h-full mb-2 overflow-y-hidden whitespace-nowrap slider shadow-lg"
      :class="this.can_swipe(blog)"
      @touchstart="$emit('touchstart', $event)"
      @touchmove="$emit('touchmove', $event, blog)"
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
            <div class="h-2/6 flex items-center justify-between relative">
              <div class="flex items-center">
                <div class="h-6 w-6 bg-white mr-2 flex items-center rounded-2xl overflow-hidden">
                  <img :src="blog.user_picture" alt="" class="h-full w-full content-cover">
                </div>
                <h2>{{ blog.user_name }}</h2>
              </div>
              <div v-if="blog.state_number === 2" :class="this.liked(blog.is_liked)" class="flex items-center">
                <i class="fas fa-star mr-1"></i>
                <p>{{ blog.liked_count }}</p>
              </div>
              <template v-else>
                <div :class="optionByState(blog.state_number).class" class="rotated h-12 w-24 border-t-4 border-white text-center absolute -right-12 -bottom-4">
                  <p class="text-sm font-bold mt-1">{{ optionByState(blog.state_number).text }}</p>
                </div>
              </template>
            </div>
          </div>
        </article>
        <div v-if="blog.user_id != user.id" class="w-3/12 bg-gold-500 h-full text-white">
          <div class="h-2/3 flex items-center justify-center">
            <img class="h-12 w-12 mt-4" src="/src/assets/star.png" alt="">
          </div>
          <p class="h-1/3 text-center font-bold">STAR</p>
        </div>
        <div v-else class="w-3/12 bg-silver-500 h-full text-white">
          <div class="h-2/3 flex items-center justify-center">
            <i class="fas fa-pen fa-2x h-12 w-12 mt-4"></i>
          </div>
          <p class="h-1/3 text-center font-bold">EDIT</p>
        </div>
      </div>
    </div>
  </transition-group>
</template>

<script>
export default {
  data(){
    return {
      options: [
        { id: 0, text: this.$t("blog.options.draft"), class: "bg-blue-800" },
        { id: 1, text: this.$t("blog.options.limited"), class: "bg-green-800" }
      ]
    }
  },
  props: {
    blogs: {
      items: []
    },
    user: {
      id: Number,
    }
  },
  methods: {
    optionByState(state_number){
      return this.options.find((item) => item.id === state_number)
    },
    can_swipe(blog){
      return blog.is_liked ? "overflow-hidden" : "overflow-x-auto";
    },
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
    },
    liked(is_liked){
      return is_liked ? "text-yellow-300" : ""
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
.rotated {
  transform: rotate(-45deg);
  -moz-transform: rotate(-45deg);
  -webkit-transform: rotate(-45deg);
}
</style>

