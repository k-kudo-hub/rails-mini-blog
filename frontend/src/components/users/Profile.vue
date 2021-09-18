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
      <ProfileCoverEdit
        v-if="isOpenCoverModal"
        :errors="errors"
        :user="user"
        @toggleCoverModal="toggleCoverModal"
        @updateUserCover="beforeUpdateUserCover"
      />
      <ProfileHeader
        :user="user"
        @toggleEditModal="toggleEditModal"
        @togglePictureModal="togglePictureModal"
        @toggleCoverModal="toggleCoverModal"
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
import axios                  from 'axios'
import User                   from '../../models/user.js'
import UserError              from '../../models/userError.js'
import { catchErrorMessages } from '../../plugins/user.js'
import ButtonDefault          from '../shared/ButtonDefault.vue'
import ProfileCards           from './ProfileCards.vue'
import ProfileEdit            from './ProfileEdit.vue'
import ProfileFooter          from './ProfileFooter.vue'
import ProfileHeader          from './ProfileHeader.vue'
import ProfilePictureEdit     from './ProfilePictureEdit.vue'
import ProfileCoverEdit       from './ProfileCoverEdit.vue'
import FlashMessage           from '../shared/FlashMessage.vue'
export default {
  data(){
    return {
      user: new User(),
      errors: new UserError(),
      displayFlashMessages: false,
      flashMessage: "",
      isOpenEditModal: false,
      isOpenPictureModal: false,
      isOpenCoverModal: false,
    }
  },
  components: {
    ButtonDefault,
    ProfileCards,
    ProfileEdit,
    ProfileFooter,
    ProfileHeader,
    ProfilePictureEdit,
    ProfileCoverEdit,
    FlashMessage,
  },
  created() {
    this.getUsersInfo()
  },
  computed: {
    whenOpenModal: function(){
      if(this.isOpenPictureModal || this.isOpenEditModal || this.isOpenCoverModal){
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
      this.errors = new UserError();
    },
    togglePictureModal(){
      this.isOpenPictureModal ? this.isOpenPictureModal = false : this.isOpenPictureModal = true;
      this.errors = new UserError();
    },
    toggleCoverModal(){
      this.isOpenCoverModal ? this.isOpenCoverModal = false : this.isOpenCoverModal = true;
      this.errors = new UserError();
    },
    // 多少非効率だが、ユーザー情報を再取得している。
    getUsersInfo(){
      axios
        .get('http://localhost:3000/api/v1/users/0')
        .then(response => {
          this.user.setData(response.data)
        })
        .catch(error => {
          console.log(error)
          this.$router.push({
            name: 'login'
          })
        })
    },
    inputValidation(){
      this.errors.name.push(this.$t("user.name") + this.$t("form.require_message"))
    },
    // プロフィール情報更新
    beforeUpdateUserInfo(...args){
      this.errors = new UserError();
      const params = args[0] // [name, introduce, link]
      if(params[0]){
        this.updateUserInfo(params[0], params[1], params[2]);
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
          this.user.setInfo(response.data)
          this.toggleEditModal()
          this.putFlashMessage(this.$t("form.update_success"))
        })
        .catch(error => {
          console.log(error.response.data)
          catchErrorMessages(error.response.data, this)
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
          this.user.setPicture(response.data)
          this.togglePictureModal()
          this.putFlashMessage(this.$t("form.update_success"))
        })
        .catch(error => {
          console.log(error.response.data)
          catchErrorMessages(error.response.data, this)
        })
    },
    // カバー更新
    beforeUpdateUserCover(...args){
      const newCover = args[0]
      if(newCover.name){
        this.updateUserCover(newCover)
      } else {
        this.errors.cover.push("ファイルが選択されていません。更新できませんでした。")
      }
    },
    updateUserCover(newCover){
      const formData = new FormData()
      formData.append('user[cover]', newCover)
      axios
        .put(`http://localhost:3000/api/v1/pictures/upload_cover`, formData)
        .then(response => {
          this.user.setCover(response.data)
          this.toggleCoverModal()
          this.putFlashMessage(this.$t("form.update_success"))
        })
        .catch(error => {
          console.log(error.response.data)
          catchErrorMessages(error.response.data, this)
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
  }
}
</script>

<style>
.h-main-fixed {
  max-height: calc(100vh - 48px - 64px - 1.5rem);
  overflow: hidden;
}
</style>
