<template>
  <div class="w-full bg-white shadow-md relative pb-5">
    <ProfileHeader/>
    <ProfileCards/>
  </div>
</template>

<script>
import dummy_header from '../../assets/dummy-header.jpg'
import logo from '../../assets/logo.png'
import ProfileHeader from './ProfileHeader.vue'
import ProfileCards from './ProfileCards.vue'
export default {
  data(){
    return {
      dummy: dummy_header,
      logo: logo
    }
  },
  components: {
    ProfileHeader,
    ProfileCards,
  }
}
</script>

<style>

</style>
