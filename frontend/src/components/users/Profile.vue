<template>
  <div :class="whenOpenModal" class="w-full bg-white shadow-md relative pb-5">
    <template v-if="user.id">
      <AssetIndex
        v-if="asset_modal.is_asset_open"
        @toggleAssetModal="toggleAssetModal"
      />
      <ProfileEdit
        v-if="modal.is_edit_open"
        :errors="errors"
        :user="user"
        @toggleEditModal="toggleEditModal"
        @updateUserInfo="beforeUpdateUserInfo"
      />
      <ProfilePictureEdit
        v-if="modal.is_picture_open"
        :errors="errors"
        :user="user"
        @togglePictureModal="togglePictureModal"
        @updateUserPicture="beforeUpdateUserPicture"
      />
      <ProfileCoverEdit
        v-if="modal.is_cover_open"
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
        :user="user"
        @toggleAssetModal="toggleAssetModal"
      />
      <flash-message-view
        :hook="flashMessage.is_displayed"
        :message="flashMessage.content"
      />
      <ProfileFooter/>
    </template>
  </div>
</template>

<script>
import axios                  from 'axios'
import AssetModal             from '../../models/asset/modal.js'
import User                   from '../../models/user/user.js'
import UserError              from '../../models/user/error.js'
import UserModal              from '../../models/user/modal.js'
import FlashMessage           from '../../models/flashMessage.js'
import AssetIndex             from '../asset/AssetIndex.vue'
import ButtonDefault          from '../shared/ButtonDefault.vue'
import ProfileCards           from './ProfileCards.vue'
import ProfileEdit            from './ProfileEdit.vue'
import ProfileFooter          from './ProfileFooter.vue'
import ProfileHeader          from './ProfileHeader.vue'
import ProfilePictureEdit     from './ProfilePictureEdit.vue'
import ProfileCoverEdit       from './ProfileCoverEdit.vue'
import FlashMessageView       from '../shared/FlashMessage.vue'
export default {
  data(){
    return {
      user: new User(),
      errors: new UserError(),
      modal: new UserModal(),
      asset_modal: new AssetModal(),
      flashMessage: new FlashMessage(),
    }
  },
  components: {
    AssetIndex,
    ButtonDefault,
    ProfileCards,
    ProfileEdit,
    ProfileFooter,
    ProfileHeader,
    ProfilePictureEdit,
    ProfileCoverEdit,
    FlashMessageView,
  },
  created() {
    this.getUsersInfo()
  },
  computed: {
    whenOpenModal: function(){
      if(this.modal.is_open() || this.asset_modal.is_open()){
        return "h-main-fixed"
      }
    }
  },
  methods: {
    toggleAssetModal(){
      this.asset_modal.toggle()
    },
    toggleEditModal(){
      this.modal.toggleEdit()
      this.errors = new UserError();
    },
    togglePictureModal(){
      this.modal.togglePicture()
      this.errors = new UserError();
    },
    toggleCoverModal(){
      this.modal.toggleCover();
      this.errors = new UserError();
    },
    // 多少非効率だが、ユーザー情報を再取得している。
    getUsersInfo(){
      axios
        .get('http://localhost:3000/api/v1/users/0')
        .then(response => {
          this.user.set(response.data)
        })
        .catch(error => {
          console.log(error)
          this.$router.push({
            name: 'login'
          })
        })
    },
    // プロフィール情報更新
    beforeUpdateUserInfo(...args){
      this.errors = new UserError();
      const params = args[0] // [name, introduce, link]
      if(params[0]){
        this.updateUserInfo(params[0], params[1], params[2]);
      } else {
        this.errors.inputValidation(this.errors.name, this.$t("user.name") + this.$t("errors.require_input"));
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
          this.flashMessage.display(this.$t("action.update") + this.$t("form.success"))
        })
        .catch(error => {
          console.log(error.response.data)
          this.errors.catchErrorMessages(error.response.data)
        })
    },
    // プロフィール画像更新
    beforeUpdateUserPicture(...args){
      const newPicture = args[0]
      if(newPicture.name){
        this.updateUserPicture(newPicture)
      } else {
        this.errors = new UserError()
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
          this.flashMessage.display(this.$t("action.update") + this.$t("form.success"))
        })
        .catch(error => {
          this.errors = new UserError()
          this.errors.catchErrorMessages(error.response.data)
        })
    },
    // カバー画像更新
    beforeUpdateUserCover(...args){
      const newCover = args[0]
      if(newCover.name){
        this.updateUserCover(newCover)
      } else {
        this.errors = new UserError()
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
          this.flashMessage.display(this.$t("action.update_success"))
        })
        .catch(error => {
          this.errors = new UserError()
          this.errors.catchErrorMessages(error.response.data)
        })
    }
  }
}
</script>

<style>
.h-main-fixed {
  max-height: calc(100vh - 48px - 64px - 1.5rem);
  overflow: hidden;
}
</style>
