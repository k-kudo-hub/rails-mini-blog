<template>
  <div class="w-full bg-white shadow-md relative p-5">
    <h1 class="mb-4 text-lg">{{ $t("session.sign_up") }}</h1>
    <form @submit.prevent>
      <div class="flex flex-col mb-3">
        <label for="name" class="mb-2 flex items-center">{{ $t("session.name") }}<span class="ml-2 bg-gold-500 text-white text-xs px-2 py-1 rounded-2xl">{{ $t("form.require") }}</span></label>
        <input v-model="user.name" name="name" :class="addErrorBorder(errors.name)" class="border-b h-10" type="text" :placeholder="$t('form.character_20')">
        <template v-if="errors.name.length > 0">
          <p v-for="(item, index) in errors.name" :key="index" class="text-red-500">{{ item }}</p>
        </template>
      </div>
      <div class="flex flex-col mb-3">
        <label for="email" class="mb-2 flex items-center">{{ $t("session.email") }}<span class="ml-2 bg-gold-500 text-white text-xs px-2 py-1 rounded-2xl">{{ $t("form.require") }}</span></label>
        <input v-model="user.email" name="email" :class="addErrorBorder(errors.email)" class="border-b h-10" type="text">
        <template v-if="errors.email.length > 0">
          <p v-for="(item, index) in errors.email" :key="index" class="text-red-500">{{ item }}</p>
        </template>
      </div>
      <div class="flex flex-col mb-5">
        <label for="password" class="mb-2 flex items-center">{{ $t("session.password") }}<span class="ml-2 bg-gold-500 text-white text-xs px-2 py-1 rounded-2xl">{{ $t("form.require") }}</span></label>
        <input v-model="user.password" name="password" :class="addErrorBorder(errors.password)" class="border-b h-10" type="password" :placeholder="$t('form.character_8_password')">
        <template v-if="errors.password.length > 0">
          <p v-for="(item, index) in errors.password" :key="index" class="text-red-500">{{ item }}</p>
        </template>
      </div>
      <div class="flex justify-end mr-4">
        <button @click="registrationUser" name="password" type="submit" class="border border-gold-500 text-gold-500 bg-white py-1 px-2 rounded-2xl shadow-md">{{ $t("session.registration") }}</button>
      </div>
    </form>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()
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
      // FIXME: Vuei18nを使用して英語でも出力できるようにしたい
      if(!this.user.name){ this.errors.name.push("ユーザー名を入力してください。") }
      if(!this.user.email){ this.errors.email.push("メールアドレスを入力してください。") }
      if(!this.user.password){ this.errors.password.push("パスワードを入力してください。") }
    },
    catchErrorMessages(errors){
      this.resetErrors()
      // FIXME: Vuei18nを使用して動的に判別したい
      errors.forEach((error) => {
        if(error.match('Name | ユーザー名')){ 
          this.errors.name.push(error)
          return
        }
        if(error.match('Email | メールアドレス')){
          this.errors.email.push(error)
          return
        }
        if(error.match('Password | パスワード')){
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
