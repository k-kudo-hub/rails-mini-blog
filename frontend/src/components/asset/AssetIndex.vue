<template>
  <div @click.self="$emit('toggleAssetModal')" class="h-full w-full bg-gray-300 bg-opacity-70 fixed top-0 left-0 z-30">
    <section class="w-11/12 bg-white fixed-center p-5">
      <header class="mb-2 flex justify-between">
        <h1>{{ $t('models.asset') + $t('action.index') }}</h1>
        <button @click="$emit('toggleAssetModal')" class="mr-2">
          <i class="fas fa-times"></i>
        </button>
      </header>
      <div class="h-96 my-3">
        <div v-if="assets.items.length > 0" class="flex flex-wrap h-full content-start overflow-scroll">
          <div v-for="asset in assets.items" :key="asset.id" class="relative h-24 w-24 mr-4 mb-2 p-2 shadow-md">
            <img class="h-full w-full object-cover object-center" :src="asset.file_url" :alt="asset.alt">
            <button v-if="forBlog" @click="$emit('insertAsset', asset)" class="absolute top-1 left-1"><i class="fas fa-plus bg-gold-500 text-white rounded-full p-1"></i></button>
            <button v-else @click="deleteAsset(asset.id)" class="absolute top-0 left-0"><i class="fas fa-times-circle fa-lg text-gray-400"></i></button>
          </div>
        </div>
        <p v-else class="text-center pt-5 text-silver-500">{{ $t('models.asset') + $t('errors.is_empty') }}</p>
      </div>
      <div :class="frame.emphasize()" class="w-full h-24 border-2 border-dashed border-gold-500 z-50">
        <form @drop.prevent="dropAsset"
              @dragenter="frame.startEmphasize"
              @dragleave="frame.stopEmphasize"
              @dragover.prevent
              @submit.prevent
              class="h-full flex justify-center items-center z-30">
          <label class="text-gold-500 text-center">
            <i class="fas fa-upload"></i> {{ $t("action.upload") }}
            <p class="text-xs">{{ $t('form.drag_and_drop') }}</p>
            <input type="file" class="hidden" @change="beforeUploadAsset">
          </label>
        </form>
      </div>
      <template v-if="errors.file.length > 0">
        <p v-for="(item, index) in errors.file" :key="index" class="my-2 text-xs text-red-500">{{ item }}</p>
      </template>
    </section>
  </div>
</template>

<script>
import axios from 'axios'
import Assets from '../../models/asset/assets.js'
import NewAsset from '../../models/asset/newAsset.js'
import Error from '../../models/asset/error.js'
import Frame from '../../models/asset/frame.js'
export default {
  data(){
    return {
      assets: new Assets(),
      newAsset: new NewAsset(),
      errors: new Error(),
      frame: new Frame(),
    }
  },
  props: {
    forBlog: {
      type: Boolean,
      require: false,
      default: false,
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
          this.assets.set(response.data)
        })
        .catch(error => {
          console.log(error.response.data)
        })
        // TODO: 処理が重い。ロード画面が欲しい。
    },
    async dropAsset(){
      this.newAsset.set([...event.dataTransfer.files][0])
      await this.uploadAsset()
    },
    async beforeUploadAsset(e){
      this.setNewAsset(e)
      await this.uploadAsset()
    },
    setNewAsset(e){
      e.preventDefault();
      this.newAsset.set(e.target.files[0])
    },
    uploadAsset(){
      const formData = new FormData()
      formData.append('asset[file]', this.newAsset.file)
      axios
        .post('http://localhost:3000/api/v1/assets', formData)
        .then(response => {
          this.assets.insert(response.data)
        })
        .catch(error => {
          console.log(error.response.data)
          this.errors.catch(error.response.data)
        })
    },
    deleteAsset(id){
      axios
        .delete(`http://localhost:3000/api/v1/assets/${id}`)
        .then(response => {
          this.assets.delete(response.data)
        })
        .catch(error => {
          console.log(error.response.data)
        })
    }
  }
}
</script>

<style>

</style>
