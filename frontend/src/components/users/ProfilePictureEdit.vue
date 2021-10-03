<template>
  <div @click.self="$emit('togglePictureModal')" class="h-full w-full bg-gray-300 bg-opacity-70 fixed top-0 left-0 z-30">
    <section class="w-11/12 bg-white fixed-center p-5">
      <h1 class="mb-4">{{ $t("user.picture") + " " + $t("action.edit") }}</h1>
      <div class="h-28 w-28 bg-gold-500 rounded-full mx-auto mb-2 flex items-center justify-center bg-white border-4 border-white overflow-hidden">
        <img v-if="propsUser.picture_url" :src="propsUser.picture_url" class="h-full w-full content-cover" alt="">
        <img v-else :src="default_image" class="h-full w-full content-cover" alt="">
      </div>
      <form @submit.prevent>
        <div class="flex items-center justify-center mb-4">
          <label class="text-gold-500">
            <i class="fas fa-upload"></i> {{ $t("action.upload") }}
            <input type="file" class="hidden" @change="setPicture">
          </label>
        </div>
        <error-message :errors="errors.picture" class="mb-3" />
        <div class="flex items-center w-3/4 justify-between mx-auto">
          <button-default
            @click="$emit('togglePictureModal')"
            :text="$t('button.cancel')"
          />
          <button-filled
            @click="$emit('updateUserPicture', newPicture)"
            :text="$t('button.updating')"
          />
        </div>
      </form>
    </section>
  </div>
</template>

<script>
import ButtonDefault from '../shared/ButtonDefault.vue'
import ErrorMessage  from '../shared/ErrorMessage.vue'
import ButtonFilled from '../shared/ButtonFilled.vue'
import default_image from '../../assets/profile_default.png'
export default {
  data(){
    return {
      default_image: default_image,
      newPicture: {},
    }
  },
  props: {
    user: {
      picture: String,
    },
    errors: {
      picture: [],
    }
  },
  components: {
    ButtonDefault,
    ButtonFilled,
    ErrorMessage
  },
  computed: {
    propsUser: {
      get(){
        return this.user
      }
    }
  },
  methods: {
    setPicture(e){
      e.preventDefault();
      this.newPicture = e.target.files[0]
      console.log(this.newPicture)
    }
  }
}
</script>
