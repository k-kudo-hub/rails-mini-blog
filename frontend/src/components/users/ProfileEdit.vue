<template>
  <div @click.self="$emit('toggleEditModal')" class="h-full w-full bg-gray-300 bg-opacity-70 fixed top-0 left-0 z-30">
    <section class="w-11/12 bg-white fixed-center p-5">
      <h1 class="mb-4">{{ $t("profile.profile") + " " + $t("action.edit") }}</h1>
      <form @submit.prevent>
        <div class="flex flex-col mb-3">
          <label for="name" class="mb-2 flex items-center">{{ $t("user.name") }}<require-label/></label>
          <input :value="propsUser.name" ref="name" :class="addErrorBorder(errors.name)" class="border-b h-10" type="text" name="name" :placeholder="$t('errors.character_20')">
          <template v-if="errors.name.length > 0">
            <p v-for="(item, index) in errors.name" :key="index" class="text-red-500">{{ item }}</p>
          </template>
        </div>
        <div class="flex flex-col mb-3">
          <label for="introduce" class="mb-2 flex items-center">{{ $t("user.introduce") }}</label>
          <textarea :value="propsUser.introduce" ref="introduce" :class="addErrorBorder(errors.introduce)" class="border-b h-20" type="text" name="introduce"></textarea>
          <template v-if="errors.introduce.length > 0">
            <p v-for="(item, index) in errors.introduce" :key="index" class="text-red-500">{{ item }}</p>
          </template>
        </div>
        <div class="flex flex-col mb-5">
          <label for="link" class="mb-2 flex items-center">{{ $t("user.link") }}</label>
          <input :value="propsUser.link" ref="link" :class="addErrorBorder(errors.link)" class="border-b h-10" type="text" name="link">
          <template v-if="errors.link.length > 0">
            <p v-for="(item, index) in errors.link" :key="index" class="text-red-500">{{ item }}</p>
          </template>
        </div>
        <div class="flex items-center w-3/4 justify-between mx-auto">
          <button-default
            @click="$emit('toggleEditModal')"
            :text="$t('button.cancel')"
          />
          <button-filled
            @click="$emit('updateUserInfo', updateUserInfoParams())"
            :text="$t('button.updating')"
          />
        </div>
      </form>
    </section>
  </div>
</template>

<script>
import ButtonDefault from '../shared/ButtonDefault.vue'
import ButtonFilled from '../shared/ButtonFilled.vue'
import RequireLabel from '../shared/RequireLabel.vue'
export default {
  props: {
    user: {
      name: String,
      introduce: String,
      link: String,
    },
    errors: {
      name: Array,
      introduce: Array,
      link: Array,
    }
  },
  components: {
    ButtonDefault,
    ButtonFilled,
    RequireLabel
  },
  computed: {
    propsUser: {
      // TODO: エラーがあった際に入力値がリセットされないようにしたい。
      get(){
        return this.user
      }
    }
  },
  methods: {
    addErrorBorder(array){
      if(array.length > 0){
        return "border-red-500"
      }
    },
    trimValue(value) {
      const res = value ? value.trim() : '';
      return res
    },
    updateUserInfoParams(){
      const name = this.trimValue(this.$refs.name.value)
      const introduce = this.trimValue(this.$refs.introduce.value)
      const link = this.trimValue(this.$refs.link.value)
      return [ name, introduce, link ]
    }
  }
}
</script>

<style>
.fixed-center {
  inset: 0;
  height: fit-content;
  position: fixed;
  margin: auto;
}
</style>
