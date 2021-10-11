<template>
  <div v-if="blog_user_id != user_id" :class="width" class="bg-gold-500 h-full text-white">
    <div class="h-2/3 flex items-center justify-center">
      <img class="h-12 w-12 mt-4" :src="img_star" alt="">
    </div>
    <p class="h-1/3 text-center font-bold">STAR</p>
  </div>
  <div v-else :class="width" class="bg-silver-500 h-full text-white">
    <div class="h-2/3 flex items-center justify-center">
      <i class="fas fa-pen fa-2x h-12 w-12 mt-4 ml-1"></i>
    </div>
    <p class="h-1/3 text-center font-bold">EDIT</p>
  </div>
</template>

<script>
import img_star from '../../assets/star.png'
export default {
  data(){
    return {
      img_star
    }
  },
  props: {
    blog_user_id: {
      type: Number,
      default: 0,
      required: true,
    },
    user_id: {
      type: Number,
      default: 0,
      required: true,
    },
    width: {
      type: String,
      default: 'w-3/12',
      required: false,
    }
  }
}
</script>
