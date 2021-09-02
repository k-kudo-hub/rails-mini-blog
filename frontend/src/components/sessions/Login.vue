<template>
  <div class="w-full bg-white shadow-md relative p-2">
    <h1 class="mb-2">ログイン</h1>
    <div v-if="errors.length > 0">
      <p v-for="(item, index) in errors" :key="index">{{ item }}</p>
    </div>
    <form @submit.prevent>
      <div class="flex flex-col mb-2">
        <label for="">メールアドレス</label>
        <input v-model="user.email" class="border" type="text">
      </div>
      <div class="flex flex-col mb-2">
        <label for="">パスワード</label>
        <input v-model="user.password" class="border" type="password">
      </div>
      <button @click="authenticateUser" type="submit">ログイン</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data(){
    return {
      user: {
        email: "",
        password: "",
      },
      errors: []
    }
  },
  methods: {
    authenticateUser(){
      if(this.user.email && this.user.password){
        axios
          .post('http://localhost:3000/api/v1/sessions.json', {
            session: {
              email: this.user.email,
              password: this.user.password
            }
          })
          .then(response => {
            console.log(`ようこそ、${response.data}さん！`)
          })
          .catch(error => {
            console.log(error.response.data)
            this.errors = ["パスワードかメールアドレスが間違っています。"]
          })
      } else {
        this.inputValidation();
      }
    },
    inputValidation(){
      if(!this.user.email){ this.errors.push('メールアドレスを入力してください。') }
      if(!this.user.password){ this.errors.push('パスワードを入力してください。') }
    }
  }
}
</script>

<style>

</style>
