<template>
  <div>
    <Header 
      :user="user"
    />
    <main class="h-main bg-gray-100">
      <router-view 
        :user="user"
      />
    </main>
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
  height: calc(100vh - 48px - 64px);
  margin-bottom: 64px;
  overflow-y: scroll;
}
</style>
