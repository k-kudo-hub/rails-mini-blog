<template>
  <section class="w-full h-full bg-white shadow-md relative p-3 mx-auto">
    <AssetIndex
      v-if="asset_modal.is_asset_open"
      @toggleAssetModal="asset_modal.toggle()"
      @insertAsset="insertAsset"
      :forBlog="true"
    />
    <form @submit.prevent class="h-full pb-3 overflow-scroll">
      <div class="flex flex-col mb-3">
        <input v-model="blog.subject" ref="subject" :class="addErrorBorder(errors.subject)" class="border-b h-10" type="text" name="subject" :placeholder="$t('blog.subject')">
        <template v-if="errors.subject.length > 0">
          <p v-for="(item, index) in errors.subject" :key="index" class="text-red-500">{{ item }}</p>
        </template>
      </div>
      <div class="mb-3 border-b h-1/16" :class="addErrorBorder(errors.cover_image)">
        <div class="flex items-center justify-between mb-2">
          <div class="text-gray-500 flex items-center">
            <label class="flex items-center">
              <i class="fab fa-cc-discover text-gray-500 mr-2"></i>
              <div class="mr-2">
                <p v-if="blog.cover_image.name">{{ blog.cover_image.name }}</p>
                <p v-else-if="blog.cover_image.url">{{ blog.cover_image_name }}</p>
                <p v-else>{{ $t('blog.cover_image') + ': ' + $t('form.not_selected') }}</p>
              </div>
              <input type="file" class="hidden w-full" @change="setCoverImage">
            </label>
          </div>
          <div class="text-gray-500 flex items-center">
            <button @click="asset_modal.toggle" v-if="!is_preview_open" class="mr-4"><i class="far fa-images ml-2"></i></button>
            <button @click="togglePreview()" v-if="is_preview_open" class="mr-4"><i class="fas fa-pen"></i></button>
            <button @click="togglePreview()" v-else class="mr-4"><i class='fas fa-eye'></i></button>
          </div>
        </div>
      </div>
      <template v-if="errors.cover_image.length > 0">
        <p v-for="(item, index) in errors.cover_image" :key="index" class="text-red-500 mb-2">{{ item }}</p>
      </template>
      <BlogMarkdown
        v-if="is_preview_open"
        :subject="blog.subject"
        :content="blog.body"
      />
      <div v-else class="flex flex-col mb-3 h-12/16">
        <textarea v-model="blog.body" ref="body" class="border-b h-full" type="text" name="body" id="blog_body" :placeholder="$t('form.blog.body_placeholder')"></textarea>
      </div>
      <div class="flex items-center h-1/16 w-3/4 justify-between mx-auto mb-2">
        <button-default
          @click="cancelUpdateBlog"
          :text="$t('button.cancel')"
        />
        <div class="flex bg-gold-500 text-white px-3 rounded-2xl shadow-md">
          <button @click="beforeUpdateBlog" class="mr-2">{{ textByState }}</button>
          <select v-model="blog.state_number" class="w-4 h-8 bg-gold-700">
            <option class="text-white" v-for="option in options" :value="option.id" :key="option.id">
              {{ option.name }}
            </option>
          </select>
        </div>
      </div>
    </form>
    <flash-message-view
      :hook="flashMessage.is_displayed"
      :message="flashMessage.content"
    />
  </section>
</template>

<script>
import axios            from 'axios'
import AssetIndex       from '../asset/AssetIndex.vue'
import AssetModal       from '../../models/asset/modal.js'
import Blog             from '../../models/blog/blog.js'
import BlogError        from '../../models/blog/error.js'
import BlogMarkdown     from './BlogMarkdown.vue'
import ButtonDefault    from '../shared/ButtonDefault.vue'
import ButtonFilled     from '../shared/ButtonFilled.vue'
import FlashMessage     from '../../models/flashMessage.js'
import FlashMessageView from '../shared/FlashMessage.vue'
import RequireLabel     from '../shared/RequireLabel.vue'
export default {
  data(){
    return {
      blog: new Blog(),
      errors: new BlogError(),
      flashMessage: new FlashMessage(),
      options: [
        { id: 0, name: this.$t("blog.options.draft") },
        { id: 1, name: this.$t("blog.options.limited") },
        { id: 2, name: this.$t("blog.options.release") },
      ],
      is_preview_open: false,
      asset_modal: new AssetModal()
    }
  },
  components: {
    AssetIndex,
    ButtonDefault,
    ButtonFilled,
    BlogMarkdown,
    RequireLabel,
    FlashMessageView
  },
  computed: {
    textByState(){
      return this.options.find((item) => item.id === this.blog.state_number).name
    },
  },
  mounted() {
    this.getBlog()
  },
  methods: {
    addErrorBorder(array){
      if(array.length > 0){
        return "border-red-500"
      }
    },
    beforeUpdateBlog(){
      if(this.blog.is_valid()){
        this.updateBlog()
      } else {
        this.errors = new BlogError()
        this.errors.inputValidation(this.errors.subject, this.$t('blog.subject') + this.$t('errors.require_input'))
      }
    },
    updateBlog(){
      axios
        .put(`http://localhost:3000/api/v1/blogs/${this.blog.url}`, this.blog.to_param())
        .then(response => {
          this.jumpToBlogsShow(response.data)
        })
        .catch(error => {
          this.errors = new BlogError()
          this.errors.catchErrorMessages(error.response.data)
        })
    },
    cancelUpdateBlog(){
      if(confirm(this.$t('form.cancel_message'))){
        this.$router.go(-1)
      }
    },
    getBlog(){
      axios
        .get(`http://localhost:3000/api/v1/blogs/${this.$route.params['url']}/edit`)
        .then(response => {
          this.blog = new Blog(response.data)
        })
        .catch(error => {
          this.errors.catch(error.response.data)
        })
    },
    jumpToBlogsShow(url){
      this.$router.push({
        name: 'blog_show',
        params: {
          url: url
        }
      })
    },
    togglePreview(){
      this.is_preview_open ? this.is_preview_open = false : this.is_preview_open = true;
    },
    insertAsset(...args){
      this.asset_modal.toggle() 
      const asset = args[0] // [id, file, alt, file_url]
      const mdText = `![${asset.alt}](${asset.file_url})`
      const target = document.getElementById('blog_body')
      setTimeout(() => {
        target.value = target.value.substr(0, target.selectionStart) + `${mdText}\n` + target.value.substr(target.selectionStart)
      }, 500);
      // TODO: 挿入後に改行やスペースを入力しないと挿入したテキストが消える問題をなんとかしたい。
    },
    setCoverImage(e){
      e.preventDefault();
      this.blog.cover_image = e.target.files[0]
      console.log(this.blog.cover_image)
    }
  }
}
</script>
