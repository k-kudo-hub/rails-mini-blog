<template>
  <div class="w-full bg-white shadow-md relative p-5">
    <h1 class="mb-4 text-lg">{{ $t("session.sign_in") }}</h1>
    <div v-if="errors.common.length > 0" class="mb-3">
      <p v-for="(item, index) in errors.common" :key="index" class="text-red-500">{{ item }}</p>
    </div>
    <form @submit.prevent>
      <div class="flex flex-col mb-3">
        <label for="email" class="mb-2 flex items-center">{{ $t("session.email") }}<require-label/></label>
        <input v-model="user.email" :class="addErrorBorder(errors.email)" class="border-b h-10" type="text" name="email">
        <template v-if="errors.email.length > 0">
          <p v-for="(item, index) in errors.email" :key="index" class="text-red-500">{{ item }}</p>
        </template>
      </div>
      <div class="flex flex-col mb-3">
        <label for="password" class="mb-2 flex items-center">パスワード<require-label/></label>
        <input v-model="user.password" :class="addErrorBorder(errors.email)" class="border-b h-10" type="password" name="password">
        <template v-if="errors.password.length > 0">
          <p v-for="(item, index) in errors.password" :key="index" class="text-red-500">{{ item }}</p>
        </template>
      </div>
      <div class="flex justify-end mr-4">
        <button-default
         @click="authenticateUser"
         :text="$t('session.sign_in')"
        />
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios'
import RequireLabel from '../shared/RequireLabel.vue'
import ButtonDefault from '../shared/ButtonDefault.vue'
export default {
  data(){
    return {
      user: {
        email: "",
        password: "",
      },
      errors: {
        email: [],
        password: [],
        common: [],
      }
    }
  },
  components: {
    RequireLabel,
    ButtonDefault
  },
  methods: {
    authenticate(){
      axios
        .post('http://localhost:3000/api/v1/sessions.json', {
          session: {
            email: this.user.email,
            password: this.user.password
          }
        })
        .then(response => {
          console.log(`ようこそ、${response.data}さん！`)
          this.$router.push({
            name: 'home'
          })
        })
        .catch(error => {
          console.log(error.response.data)
          this.resetErrors()
          this.errors.common.push(this.$t("form.wrong_message"))
        })
    },
    authenticateUser(){
      if(this.user.email && this.user.password){
        this.authenticate();
      } else {
        this.inputValidation();
      }
    },
    inputValidation(){
      this.resetErrors()
      if(!this.user.email){ this.errors.email.push(this.$t("session.email") + this.$t("form.require_message")) }
      if(!this.user.password){ this.errors.password.push(this.$t("session.password") + this.$t("form.require_message")) }
    },
    resetErrors(){
      // FIXME: 初期化する関数に置き換えたい
      this.errors = { common: [], email: [], password: [] }
    },
    addErrorBorder(array){
      if(array.length > 0){
        return "border-red-500"
      }
    }
  }
}
</script>

<style>

</style>
