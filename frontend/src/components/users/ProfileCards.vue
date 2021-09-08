<template>
  <section class="mx-2 mb-4">
    <h1 class="mb-2 text-xl">{{ $t("profile.blogs") }}</h1>
    <article :style="exportBgImage(card.cover)" class="bg-center bg-cover h-24 mb-2" v-for="card in cards" :key="card.id">
      <div class="w-full h-full bg-black bg-opacity-50 text-white pl-4">
        <h1 class="h-1/2 flex items-center">{{ card.title }}</h1>
        <div class="h-1/2 flex items-center">
          <div class="h-6 w-6 bg-white rounded-2xl mr-2 flex justify-center items-center">
            <img :src="exportCardProfileImage(card.picture)" alt="" height="20" width="20">
          </div>
          <p>{{ card.name }}</p>
        </div>
      </div>
    </article>
  </section>
</template>

<script>
export default {
  data(){
    return {
      cards: [
        {
          id: 1,
          title: "dummy blog title",
          cover: "dummy-header.jpg",
          picture: "logo.png",
          name: "John Star"
        },
        {
          id: 2,
          title: "dummy blog title2",
          cover: "dummy-header2.jpg",
          picture: "logo.png",
          name: "Ivan Lod"
        },
        {
          id: 3,
          title: "dummy blog title3",
          cover: "dummy-header3.jpg",
          picture: "logo.png",
          name: "Jeff Arren"
        }
      ]
    }
  },
  methods: {
    exportBgImage(file){
      return `background-image: url('/src/assets/${file}')`
    },
    exportCardProfileImage(file){
      return `/src/assets/${file}`
    }
  }
}
</script>

<style>

</style>