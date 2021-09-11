<template>
  <div class="flex justify-end mr-4">
    <button-default
      @click="$emit('signOut')"
      :text="$t('session.sign_out')"
    />
  </div>
</template>

<script>
import ButtonDefault from '../shared/ButtonDefault.vue'
export default {
  components: {
    ButtonDefault,
  }
}
</script>

<style>

</style>
