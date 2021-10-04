<template>
  <div class="w-full bg-white shadow-md relative p-5">
    <h1 class="mb-4 text-lg">{{ $t("session.sign_up") }}</h1>
    <form @submit.prevent>
      <div class="flex flex-col mb-3">
        <label for="name" class="mb-2 flex items-center">{{ $t("user.name") }}<require-label/></label>
        <input v-model="visitor.name" name="name" :class="addErrorBorder(errors.name)" class="border-b h-10" type="text" :placeholder="$t('errors.character_20')">
        <error-message :errors="errors.name" />
      </div>
      <div class="flex flex-col mb-3">
        <label for="email" class="mb-2 flex items-center">{{ $t("user.email") }}<require-label/></label>
        <input v-model="visitor.email" name="email" :class="addErrorBorder(errors.email)" class="border-b h-10" type="text">
        <error-message :errors="errors.email" />
      </div>
      <div class="flex flex-col mb-5">
        <label for="password" class="mb-2 flex items-center">{{ $t("user.password") }}<require-label/></label>
        <input v-model="visitor.password" name="password" :class="addErrorBorder(errors.password)" class="border-b h-10" type="password" :placeholder="$t('errors.character_8_password')">
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
import axios         from 'axios'
import ButtonDefault from '../shared/ButtonDefault.vue'
import Error         from '../../models/visitor/error.js'
import ErrorMessage  from '../shared/ErrorMessage.vue'
import RequireLabel  from '../shared/RequireLabel.vue'
import Visitor       from '../../models/visitor/visitor.js'
export default {
  data(){
    return {
      visitor: new Visitor(),
      errors: new Error(),
    }
  },
  props: {
    user: {
      id: Number,
    }
  },
  components: {
    ButtonDefault,
    ErrorMessage,
    RequireLabel,
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
    registration(){
      axios
        .post('http://localhost:3000/api/v1/users.json', this.visitor.to_param_for_registration())
        .then(response => {
          this.$router.go()
        })
        .catch(error => {
          this.errors = new Error()
          this.errors.catchErrorMessages(error.response.data)
        })
    },
    registrationUser(){
      if(this.visitor.is_valid_for_registration()) {
        this.registration();
      } else {
        this.inputValidation();
      }
    },
    inputValidation(){
      this.errors = new Error()
      if(!this.visitor.name){ this.errors.name.push(this.$t("user.name") + this.$t("errors.require_input")) }
      if(!this.visitor.email){ this.errors.email.push(this.$t("user.email") + this.$t("errors.require_input")) }
      if(!this.visitor.password){ this.errors.password.push(this.$t("user.password") + this.$t("errors.require_input")) }
    },
    addErrorBorder(array){
      if(array.length > 0) return "border-red-500"
    }
  }
}
</script>
