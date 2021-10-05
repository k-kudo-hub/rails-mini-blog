<template>
  <footer class="h-36 w-full mb-4">
    <div class="h-3/4 flex">
      <div class="w-1/6 flex justify-center pt-2">
        <img :src="pictureUrl" alt="" class="h-10 w-10 rounded-full">
      </div>
      <div class="w-5/6">
        <h1 class="h-1/4 font-bold text-lg">{{ user_name }}</h1>
        <p class="h-3/4 text-sm">{{ user_introduce }}</p>
      </div>
    </div>
    <div class="h-1/4 flex justify-center items-center">
      <button-filled
        :text="$t('profile.profile')"
      />
    </div>
  </footer>
</template>

<script>
import ButtonDefault from '../shared/ButtonDefault.vue'
import ButtonFilled  from '../shared/ButtonFilled.vue'
import default_user_picture from '../../assets/profile_default.png'
export default {
  data(){
    return {
      default_user_picture,
    }
  },
  components: {
    ButtonDefault,
    ButtonFilled,
  },
  props: {
    user_id: Number,
    user_name: String,
    user_picture: String,
    user_introduce: String,
  },
  computed: {
    pictureUrl(){
      return this.user_picture ? this.user_picture : this.default_user_picture
    }
  }
}
</script>
