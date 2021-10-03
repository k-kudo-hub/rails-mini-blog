<template>
  <div class="w-full bg-white shadow-md relative p-5">
    <h1 class="mb-4 text-lg">{{ $t("session.sign_up") }}</h1>
    <form @submit.prevent>
      <div class="flex flex-col mb-3">
        <label for="name" class="mb-2 flex items-center">{{ $t("user.name") }}<require-label/></label>
        <input v-model="user.name" name="name" :class="addErrorBorder(errors.name)" class="border-b h-10" type="text" :placeholder="$t('errors.character_20')">
        <error-message :errors="errors.name" />
      </div>
      <div class="flex flex-col mb-3">
        <label for="email" class="mb-2 flex items-center">{{ $t("user.email") }}<require-label/></label>
        <input v-model="user.email" name="email" :class="addErrorBorder(errors.email)" class="border-b h-10" type="text">
        <error-message :errors="errors.email" />
      </div>
      <div class="flex flex-col mb-5">
        <label for="password" class="mb-2 flex items-center">{{ $t("user.password") }}<require-label/></label>
        <input v-model="user.password" name="password" :class="addErrorBorder(errors.password)" class="border-b h-10" type="password" :placeholder="$t('errors.character_8_password')">
        <error-message :errors="errors.password" />
      </div>
      <div class="flex justify-end mr-4">
        <button-default 
          @click="registrationUser"
          :text="$t('session.registration')"
        />
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios'
import RequireLabel from '../shared/RequireLabel.vue'
import ButtonDefault from '../shared/ButtonDefault.vue'
import Error         from '../../models/visitor/error.js'
export default {
  data(){
    return {
      user: {
        name: "",
        email: "",
        password: "",
      },
      errors: {
        name: [],
        email: [],
        password: [],
      }
    }
  },
  components: {
    ErrorMessage,
    RequireLabel,
    ButtonDefault
  },
  methods: {
    registration(){
      axios
        .post('http://localhost:3000/api/v1/users.json', {
          user: {
            name: this.user.name,
            email: this.user.email,
            password: this.user.password
          }
        })
        .then(response => {
          console.log(`${response.data}さんの登録が成功しました！`)
          this.resetErrors()
          this.$router.push({
            name: 'home'
          })
        })
        .catch(error => {
          console.log(error.response.data)
          this.catchErrorMessages(error.response.data)
        })
    },
    registrationUser(){
      if(this.user.name && this.user.email && this.user.password) {
        this.registration();
      } else {
        this.inputValidation();
      }
    },
    inputValidation(){
      this.resetErrors()
      if(!this.user.name){ this.errors.name.push(this.$t("user.name") + this.$t("errors.require_input")) }
      if(!this.user.email){ this.errors.email.push(this.$t("user.email") + this.$t("errors.require_input")) }
      if(!this.user.password){ this.errors.password.push(this.$t("user.password") + this.$t("errors.require_input")) }
    },
    catchErrorMessages(errors){
      this.resetErrors()
      // FIXME: Vuei18nを使用して動的に判別したい
      errors.forEach((error) => {
        if(error.match('Name|ユーザー名')){ 
          this.errors.name.push(error)
          return
        }
        if(error.match('Email|メールアドレス')){
          this.errors.email.push(error)
          return
        }
        if(error.match('Password|パスワード')){
          this.errors.password.push(error)
          return
        }
      })
    },
    resetErrors(){
      // FIXME: 初期化する関数に置き換えたい
      this.errors = { name: [], email: [], password: [] }
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
