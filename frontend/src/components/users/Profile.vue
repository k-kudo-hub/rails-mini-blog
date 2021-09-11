<template>
  <div class="w-full bg-white shadow-md relative pb-5">
    <template v-if="user.id">
      <ProfileEdit
        :user="user"
        :errors="errors"
        v-if="isOpenEditModal"
        @toggleEditModal="toggleEditModal"
        @updateUser="updateUser"
      />
      <ProfileHeader
        :user="user"
        @toggleEditModal="toggleEditModal"
      />
      <ProfileCards
      />
      <transition name="component-fade">
        <div v-if="displayFlashMessages" class="w-full fixed bottom-20">
          <p class="bg-gold-500 text-white w-3/4 p-2 z-50 rounded-3xl text-center mx-auto">{{ flashMessage }}</p>
        </div>
      </transition>
      <ProfileFooter
        @signOut="signOut"
      />
    </template>
    <template v-else>
      <!-- TODO: 可能であればリダイレクト&リロードしたい -->
      <p class="text-center pt-3">ログインしてブログを書いてみましょう。</p>
    </template>
  </div>
</template>

<script>
import axios from 'axios'
import dummy_header from '../../assets/dummy-header.jpg'
import logo from '../../assets/logo.png'
import ButtonDefault from '../shared/ButtonDefault.vue'
import ProfileCards from './ProfileCards.vue'
import ProfileEdit from './ProfileEdit.vue'
import ProfileFooter from './ProfileFooter.vue'
import ProfileHeader from './ProfileHeader.vue'
export default {
  data(){
    return {
      dummy: dummy_header,
      logo: logo,
      isOpenEditModal: false,
      user: {
        id: 0,
        name: "",
        introduce: "",
        picture: "",
        cover: "",
        link: "",
      },
      errors: {
        name: [],
        introduce: [],
        link: [],
      },
      flashMessage: "",
      displayFlashMessages: false,
    }
  },
  components: {
    ProfileCards,
    ProfileEdit,
    ProfileFooter,
    ProfileHeader,
    ButtonDefault,
  },
  created() {
    this.getUsersInfo()
  },
  methods: {
    signOut(){
      axios
        .delete('http://localhost:3000/api/v1/sessions/0')
        .then(response => {
          this.$router.go({
            name: 'home',
          })
        })
    },
    toggleEditModal(){
      this.isOpenEditModal ? this.isOpenEditModal = false : this.isOpenEditModal = true;
    },
    // 多少非効率だが、ユーザー情報を再取得している。
    getUsersInfo(){
      axios
        .get('http://localhost:3000/api/v1/users/0')
        .then(response => {
          this.user = response.data
          console.log(this.user)
        })
        .catch(error => {
          console.log(error)
        })
    },
    inputValidation(){
      this.resetErrors()
      this.errors.name.push(this.$t("user.name") + this.$t("form.require_message"))
    },
    catchErrorMessages(errors){
      this.resetErrors()
      // FIXME: Vuei18nを使用して動的に判別したい
      errors.forEach((error) => {
        if(error.match('Name | ユーザー名')){ 
          this.errors.name.push(error)
          return
        }
        if(error.match('Introduce | 自己紹介')){
          this.errors.introduce.push(error)
          return
        }
        if(error.match('Link | URL')){
          this.errors.link.push(error)
          return
        }
      })
    },
    update(){
      axios
        .put(`http://localhost:3000/api/v1/users/${this.user.id}`,{
          user: {
            name: this.user.name,
            introduce: this.user.introduce,
            link: this.user.link,
          }
        })
        .then(response => {
          console.log(response.data)
          this.toggleEditModal()
          this.putFlashMessage(this.$t("form.update_success"))
        })
        .catch(error => {
          console.log(error.response.data)
          this.catchErrorMessages(error.response.data)
        })
    },
    updateUser(){
      if(this.user.name){
        this.update();
      } else {
        this.inputValidation();
      }
    },
    putFlashMessage(message){
      this.flashMessage = message
      this.displayFlashMessages = true
      setTimeout(() => {
        this.displayFlashMessages = false
      }, 2000)
    },
    resetErrors(){
      // FIXME: 初期化する関数に置き換えたい
      this.errors = { name: [], introduce: [], link: [] }
    },
  }
}
</script>

<style>
.component-fade-enter-active,
.component-fade-leave-active {
  transition: opacity .3s ease;
}
.component-fade-enter,
.component-fade-leave-to {
  opacity: 0;
}
</style>
