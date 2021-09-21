<template>
  <div>
    <Header 
      :user="user"
    />
    <article class="h-main p-3 bg-gray-100">
      <router-view 
        :user="user"
      />
    </article>
    <Footer 
      :user="user"
    />
  </div>
</template>

<script>
import axios from 'axios'
import Header from './components/shared/Header.vue'
import Footer from './components/shared/Footer.vue'
export default {
  data(){
    return {
      user: {
        id: 0,
        name: "",
        introduce: "",
        picture: "",
        cover: "",
        link: "",
      }
    }
  },
  components: {
    Footer,
    Header,
  },
  mounted(){
    this.getUsersInfo();
  },
  methods: {
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
    }
  }
}
</script>

<style>
.h-main {
  min-height: calc(100vh - 48px - 64px);
  margin-bottom: 64px;
}
</style>
