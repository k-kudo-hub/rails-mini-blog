<template>
  <section class="w-full bg-white shadow-md relative p-5 mx-auto">
    <h1 class="mb-4">{{ $t('models.blog') + $t('form.create') }}</h1>
    <form @submit.prevent>
      <div class="flex flex-col mb-3">
        <label for="subject" class="mb-2 flex items-center">{{ $t('blog.subject') }}<require-label/></label>
        <input v-model="blog.subject" ref="subject" :class="addErrorBorder(errors.subject)" class="border-b h-10" type="text" name="subject" :placeholder="$t('form.character_20')">
        <template v-if="errors.subject.length > 0">
          <p v-for="(item, index) in errors.subject" :key="index" class="text-red-500">{{ item }}</p>
        </template>
      </div>
      <div class="flex flex-col mb-3">
        <label for="body" class="mb-2 flex items-center">{{ $t('blog.body') }}</label>
        <textarea v-model="blog.body" ref="body" class="border-b h-20" type="text" name="body"></textarea>
      </div>
      <div class="flex mb-5">
        <select v-model="blog.state_number" class="w-1/2 h-8 border-2 border-gold-500">
          <option v-for="option in options" :value="option.id" :key="option.id">
            {{ option.name }}
          </option>
        </select>
        <template v-if="errors.state_number.length > 0">
          <p v-for="(item, index) in errors.subject" :key="index" class="text-red-500">{{ item }}</p>
        </template>
      </div>
      <div class="flex items-center w-3/4 justify-between mx-auto">
        <button-default
          @click="cancelCreateBlog"
          :text="$t('form.cancel')"
        />
        <button-filled
          @click="beforeCreateBlog"
          :text="$t('form.saving')"
        />
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
import Blog             from '../../models/blog/blog.js'
import BlogError        from '../../models/blog/error.js'
import ButtonDefault    from '../shared/ButtonDefault.vue'
import ButtonFilled     from '../shared/ButtonFilled.vue'
import FlashMessage     from '../../models/flashMessage.js'
import RequireLabel     from '../shared/RequireLabel.vue'
import FlashMessageView from '../shared/FlashMessage.vue'
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
      ]
    }
  },
  components: {
    ButtonDefault,
    ButtonFilled,
    RequireLabel,
    FlashMessageView
  },
  methods: {
    addErrorBorder(array){
      if(array.length > 0){
        return "border-red-500"
      }
    },
    beforeCreateBlog(){
      if(this.blog.is_valid()){
        this.createBlog()
      } else {
        this.errors.inputValidation(this.errors.subject, "タイトルを入力してください")
      }
    },
    createBlog(){
      axios
        .post(`http://localhost:3000/api/v1/blogs/`, this.blog.params())
        .then(response => {
          this.blog.set(response.data)
          this.flashMessage.display(this.$t("form.save") + this.$t("form.success"))
        })
        .catch(error => {
          this.errors = new BlogError()
          this.errors.catchErrorMessages(error.response.data)
        })
    },
    cancelCreateBlog(){
      if(confirm('作成をキャンセルしますか？変更は保存されません。')){
        this.blog = new Blog()
      }
    }
  }
}
</script>

<style>

</style>
