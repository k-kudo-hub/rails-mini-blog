<template>
  <div @click.self="$emit('toggleCoverModal')" class="h-full w-full bg-gray-300 bg-opacity-70 fixed top-0 left-0 z-30">
    <section class="w-11/12 bg-white fixed-center p-5">
      <h1 class="mb-4">{{ $t("user.cover") + " " + $t("action.edit") }}</h1>
      <div class="h-32 w-64 bg-white mx-auto mb-2 flex items-center justify-center bg-white overflow-hidden">
        <img v-if="propsUser.cover_url" :src="propsUser.cover_url" class="w-full h-full object-cover" alt="">
        <img v-else :src="dummy_header" class="w-full h-full object-cover" alt="">
      </div>
      <form @submit.prevent>
        <div class="flex items-center justify-center mb-4">
          <label class="text-gold-500">
            <i class="fas fa-upload"></i> {{ $t("action.upload") }}
            <input type="file" class="hidden" @change="setCover">
          </label>
        </div>
        <error-message :errors="errors.cover" class="mb-3" />
        <div class="flex items-center w-3/4 justify-between mx-auto">
          <button-default
          @click="$emit('toggleCoverModal')"
          :text="$t('button.cancel')"
          />
          <button-filled
          @click="$emit('updateUserCover', newCover)"
          :text="$t('button.updating')"
          />
        </div>
      </form>
    </section>
  </div>
</template>

<script>
import ButtonDefault from '../shared/ButtonDefault.vue'
import ButtonFilled from '../shared/ButtonFilled.vue'
import dummy_header from '../../assets/dummy-header.jpg'
import ErrorMessage from '../shared/ErrorMessage.vue'
export default {
  data(){
    return {
      dummy_header: dummy_header,
      newCover: {},
    }
  },
  props: {
    user: {
      cover: String,
    },
    errors: {
      cover: [],
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
    setCover(e){
      e.preventDefault();
      this.newCover = e.target.files[0]
      console.log(this.newCover)
    }
  }
}
</script>

<style>

</style>
