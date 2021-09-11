<template>
  <div @click.self="$emit('togglePictureModal')" class="h-full w-full bg-gray-300 bg-opacity-70 fixed top-0 left-0 z-30">
    <section class="w-11/12 bg-white fixed-center p-5">
      <h1 class="mb-4">{{ $t("user.picture") + " " + $t("form.edit") }}</h1>
      <div class="h-28 w-28 bg-gold-500 rounded-full mx-auto mb-2 flex items-center justify-center bg-white border-4 border-white overflow-hidden">
        <img v-if="propsUser.picture_url" :src="returnPictureFullPath(propsUser.picture_url)" height="112" width="112" alt="">
        <img v-else :src="default_image" height="100" width="100" alt="">
      </div>
      <form @submit.prevent>
        <div class="flex items-center justify-center mb-4">
          <label class="text-gold-500">
            <i class="fas fa-upload"></i> {{ $t("form.upload") }}
            <input type="file" class="hidden" @change="setPicture">
          </label>
        </div>
        <div v-if="errors.picture.length > 0" class="mb-3">
          <p v-for="(item, index) in errors.picture" :key="index" class="text-red-500">{{ item }}</p>
        </div>
        <div class="flex items-center w-3/4 justify-between mx-auto">
          <button-default
          @click="$emit('togglePictureModal')"
          :text="$t('form.cancel')"
          />
          <button-filled
          @click="$emit('updateUserPicture', newPicture)"
          :text="$t('form.update')"
          />
        </div>
      </form>
    </section>
  </div>
</template>

<script>
import ButtonDefault from '../shared/ButtonDefault.vue'
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
      cover: String,
    },
    errors: {
      picture: [],
      cover: [],
    }
  },
  components: {
    ButtonDefault,
    ButtonFilled,
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
    },
    returnPictureFullPath(path){
      return 'http://localhost:3000'+path
    }
  }
}
</script>

<style>

</style>
