<template>
  <div @click.self="$emit('toggleAssetModal')" class="h-full w-full bg-gray-300 bg-opacity-70 fixed top-0 left-0 z-30">
    <section class="w-11/12 bg-white fixed-center p-5">
      <h1 class="mb-2">素材一覧</h1>
      <div class="h-96 my-3">
        <div v-if="assets.length > 0" class="flex flex-wrap h-full overflow-scroll">
          <img v-for="asset in assets" class="mr-4 mb-2 p-2 h-24 w-24 shadow-md object-cover object-center" :key="asset.id" :src="asset.file_url" :alt="asset.alt">
        </div>
        <p v-else class="text-center pt-5 text-silver-500">素材がありません。</p>
      </div>
      <div :class="frame.emphasize()" class="w-full h-24 border-2 border-dashed border-gold-500">
      </div>
      <template v-if="errors.file.length > 0">
        <p v-for="(item, index) in errors.file" :key="index" class="my-2 text-xs text-red-500">{{ item }}</p>
      </template>
    </section>
  </div>
</template>

<script>
import axios from 'axios'
import NewAsset from '../../models/asset/newAsset.js'
export default {
  data(){
    return {
      assets: [],
    }
  },
  created(){
    this.getAssets()
  },
  methods: {
    getAssets(){
      axios
        .get('http://localhost:3000/api/v1/assets')
        .then(response => {
          this.assets = response.data
        })
        .catch(error => {
          console.log(error.response.data)
        })
    },
  }
}
</script>

<style>

</style>
