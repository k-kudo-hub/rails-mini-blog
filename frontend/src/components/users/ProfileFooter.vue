<template>
  <div class="flex justify-end mr-4">
    <button-default
      @click="signOut"
      :text="$t('session.sign_out')"
    />
  </div>
</template>

<script>
import axios from 'axios'
import ButtonDefault from '../shared/ButtonDefault.vue'
export default {
  components: {
    ButtonDefault,
  },
  methods: {
    signOut(){
      axios
        .delete('http://localhost:3000/api/v1/sessions/0')
        .then(response => {
          this.$router.go()
        })
    },
  }
}
</script>
