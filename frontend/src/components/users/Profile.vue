<template>
  <div :class="whenOpenModal" class="w-full bg-white shadow-md relative pb-5">
    <template v-if="user.id">
      <ProfileEdit
        v-if="isOpenEditModal"
        :errors="errors"
        :user="user"
        @toggleEditModal="toggleEditModal"
        @updateUserInfo="beforeUpdateUserInfo"
      />
      <ProfilePictureEdit
        v-if="isOpenPictureModal"
        :errors="errors"
        :user="user"
        @togglePictureModal="togglePictureModal"
        @updateUserPicture="beforeUpdateUserPicture"
      />
      <ProfileHeader
        :user="user"
        @toggleEditModal="toggleEditModal"
        @togglePictureModal="togglePictureModal"
      />
      <ProfileCards
      />
      <flash-message
        :hook="displayFlashMessages"
        :message="flashMessage"
      />
      <ProfileFooter
        @signOut="signOut"
      />
    </template>
  </div>
</template>

<script>
import axios              from 'axios'
import ButtonDefault      from '../shared/ButtonDefault.vue'
import ProfileCards       from './ProfileCards.vue'
import ProfileEdit        from './ProfileEdit.vue'
import ProfileFooter      from './ProfileFooter.vue'
import ProfileHeader      from './ProfileHeader.vue'
import ProfilePictureEdit from './ProfilePictureEdit.vue'
import FlashMessage       from '../shared/FlashMessage.vue'
export default {
  data(){
    return {
      user: {
        id: 0,
        name: "",
        introduce: "",
        picture: "",
        picture_url: "",
        cover: "",
        link: "",
      },
      errors: {
        name: [],
        introduce: [],
        link: [],
        picture: [],
      },
      displayFlashMessages: false,
      flashMessage: "",
      isOpenEditModal: false,
      isOpenPictureModal: false,
    }
  },
  components: {
    ButtonDefault,
    ProfileCards,
    ProfileEdit,
    ProfileFooter,
    ProfileHeader,
    ProfilePictureEdit,
    FlashMessage,
  },
  created() {
    this.getUsersInfo()
  },
  computed: {
    whenOpenModal: function(){
      if(this.isOpenPictureModal || this.isOpenEditModal){
        return "h-main-fixed"
      }
    }
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
    togglePictureModal(){
      this.isOpenPictureModal ? this.isOpenPictureModal = false : this.isOpenPictureModal = true;
      this.resetErrors()
    },
    // 多少非効率だが、ユーザー情報を再取得している。
    getUsersInfo(){
      axios
        .get('http://localhost:3000/api/v1/users/0')
        .then(response => {
          this.user = response.data
        })
        .catch(error => {
          console.log(error)
          this.$router.push({
            name: 'login'
          })
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
        if(error.match('Picture | プロフィール画像')){
          this.errors.picture.push(error)
          return
        }
        if(error.match('Cover | カバー画像')){
          this.errors.picture.push(error)
          return
        }
      })
    },
    // プロフィール情報更新
    beforeUpdateUserInfo(...args){
      if(args[0]){
        this.updateUserInfo(args[0], args[1], args[2]);
      } else {
        this.inputValidation();
      }
    },
    updateUserInfo(newName, newIntroduce, newLink){
      axios
        .put(`http://localhost:3000/api/v1/users/${this.user.id}`,{
          user: {
            name: newName,
            introduce: newIntroduce,
            link: newLink,
          }
        })
        .then(response => {
          this.user.name = response.data.name
          this.user.introduce = response.data.introduce
          this.user.link = response.data.link
          this.toggleEditModal()
          this.putFlashMessage(this.$t("form.update_success"))
        })
        .catch(error => {
          console.log(error.response.data)
          this.catchErrorMessages(error.response.data)
        })
    },
    // プロフィール画像・カバー更新
    beforeUpdateUserPicture(...args){
      const newPicture = args[0]
      if(newPicture.name){
        this.updateUserPicture(newPicture)
      } else {
        this.errors.picture.push("ファイルが選択されていません。更新できませんでした。")
      }
    },
    updateUserPicture(newPicture){
      const formData = new FormData()
      formData.append('user[picture]', newPicture)
      axios
        .put(`http://localhost:3000/api/v1/pictures/upload_picture`, formData)
        .then(response => {
          this.user.picture_url = response.data
          this.togglePictureModal()
          this.putFlashMessage(this.$t("form.update_success"))
        })
        .catch(error => {
          console.log(error.response.data)
          this.catchErrorMessages(error.response.data)
        })
    },
    // 更新時フラッシュメッセージ出力
    putFlashMessage(message){
      this.flashMessage = message
      this.displayFlashMessages = true
      setTimeout(() => {
        this.displayFlashMessages = false
      }, 2000)
    },
    resetErrors(){
      // FIXME: 初期化する関数に置き換えたい
      this.errors = { name: [], introduce: [], link: [], picture: [] }
    },
  }
}
</script>

<style>
.h-main-fixed {
  max-height: calc(100vh - 48px - 64px - 1.5rem);
  overflow: hidden;
}
</style>
