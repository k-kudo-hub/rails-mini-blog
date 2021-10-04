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
      errors: new Error()
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
    authenticate(){
      axios
        .post('http://localhost:3000/api/v1/sessions.json', this.visitor.to_param_for_login())
        .then(response => {
          console.log(`ようこそ、${response.data.name}さん！`)
          this.$router.go()
        })
        .catch(error => {
          this.errors = new Error()
          this.errors.common.push(this.$t("errors.wrong_message"))
        })
    },
    authenticateVisitor(){
      if(this.visitor.is_valid_for_login()){
        this.authenticate();
      } else {
        this.inputValidation();
      }
    },
    inputValidation(){
      this.errors = new Error()
      if(!this.visitor.email){ this.errors.email.push(this.$t("user.email") + this.$t("errors.require_input")) }
      if(!this.visitor.password){ this.errors.password.push(this.$t("user.password") + this.$t("errors.require_input")) }
    },
    addErrorBorder(array){
      if(array.length > 0) return "border-red-500";
    }
  }
}
</script>
