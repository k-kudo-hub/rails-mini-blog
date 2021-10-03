<template>
  <div class="w-full bg-white shadow-md relative p-5">
    <template v-if="!user.id">
      <h1 class="mb-4 text-lg">{{ $t("session.sign_in") }}</h1>
      <error-message :errors="errors.common" class="mb-3" />
      <form @submit.prevent>
        <div class="flex flex-col mb-3">
          <label for="email" class="mb-2 flex items-center">{{ $t("user.email") }}<require-label/></label>
          <input v-model="visitor.email" :class="addErrorBorder(errors.email)" class="border-b h-10" type="text" name="email">
          <error-message :errors="errors.email" class="mb-3" />
        </div>
        <div class="flex flex-col mb-3">
          <label for="password" class="mb-2 flex items-center">{{ $t("user.password") }}<require-label/></label>
          <input v-model="visitor.password" :class="addErrorBorder(errors.password)" class="border-b h-10" type="password" name="password">
          <error-message :errors="errors.password" class="mb-3" />
        </div>
        <div class="flex justify-end mr-4">
          <button-default
          @click="authenticateVisitor"
          :text="$t('session.sign_in')"
          />
        </div>
      </form>
    </template>
  </div>
</template>

<script>
import axios from 'axios'
import RequireLabel from '../shared/RequireLabel.vue'
import ButtonDefault from '../shared/ButtonDefault.vue'
import ErrorMessage  from '../shared/ErrorMessage.vue'
export default {
  data(){
    return {
      visitor: {
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
  props: {
    user: {
      id: Number,
      name: String,
      introduce: String,
      picture: String,
      cover: String,
    }
  },
  components: {
    ErrorMessage,
    RequireLabel,
    ButtonDefault
  },
  watch: {
    'user.id': function(val){
      if(val){
        this.$router.push({
          path: "/profile"
        })
      }
    }
  },
  methods: {
    authenticate(){
      axios
        .post('http://localhost:3000/api/v1/sessions.json', {
          session: {
            email: this.visitor.email,
            password: this.visitor.password
          }
        })
        .then(response => {
          console.log(`ようこそ、${response.data.name}さん！`)
          this.$router.go({
            name: 'home',
          })
        })
        .catch(error => {
          console.log(error.response.data)
          this.resetErrors()
          this.errors.common.push(this.$t("errors.wrong_message"))
        })
    },
    authenticateVisitor(){
      if(this.visitor.email && this.visitor.password){
        this.authenticate();
      } else {
        this.inputValidation();
      }
    },
    inputValidation(){
      this.resetErrors()
      if(!this.visitor.email){ this.errors.email.push(this.$t("user.email") + this.$t("errors.require_input")) }
      if(!this.visitor.password){ this.errors.password.push(this.$t("user.password") + this.$t("errors.require_input")) }
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
