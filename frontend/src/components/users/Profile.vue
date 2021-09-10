<template>
  <div class="w-full bg-white shadow-md relative pb-5">
    <template v-if="user.id">
      <ProfileEdit
        v-if="isOpenEditModal"
        @toggleEditModal="toggleEditModal"
      />
      <ProfileHeader
        :user="user"
        @toggleEditModal="toggleEditModal"
      />
      <ProfileCards
      />
      <div class="flex justify-end mr-4">
        <button-default
          @click="signOut"
          :text="$t('session.sign_out')"
        />
      </div>
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
import ProfileHeader from './ProfileHeader.vue'
export default {
  data(){
    return {
      dummy: dummy_header,
      logo: logo,
      isOpenEditModal: false,
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
    ProfileCards,
    ProfileEdit,
    ProfileHeader,
    ButtonDefault,
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
    }
  }
}
</script>

<style>

</style>
