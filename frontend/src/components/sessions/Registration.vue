<template>
  <div class="w-full bg-white shadow-md relative p-2">
    <h1 class="mb-2">新規登録</h1>
    <div v-if="errors.length > 0">
      <p v-for="(item, index) in errors" :key="index">{{ item }}</p>
    </div>
    <form @submit.prevent>
      <div class="flex flex-col mb-2">
        <label for="name">ユーザー名</label>
        <input v-model="user.name" name="name" class="border" type="text">
      </div>
      <div class="flex flex-col mb-2">
        <label for="email">メールアドレス</label>
        <input v-model="user.email" name="email" class="border" type="text">
      </div>
      <div class="flex flex-col mb-2">
        <label for="password">パスワード</label>
        <input v-model="user.password" class="border" type="password">
      </div>
      <button @click="registrationUser" name="password" type="submit">登録する</button>
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
      errors: []
    }
  },
  methods: {
    registrationUser(){
      if(this.user.name && this.user.email && this.user.password) {
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
          })
          .catch(error => {
            console.log(error.response.data)
            this.errors = error.response.data
          })   
      } else {
        this.inputValidation();
      }
    },
    inputValidation(){
      this.errors = [];
      if(!this.user.name){ this.errors.push("ユーザー名を入力してください。") }
      if(!this.user.email){ this.errors.push("メールアドレスを入力してください。") }
      if(!this.user.password){ this.errors.push("パスワードを入力してください。") }
    }
  }
}
</script>

<style>

</style>
