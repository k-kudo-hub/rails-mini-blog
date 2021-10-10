<template>
  <section>
    <div v-if="state_number === 2" :class="liked(is_liked)" class="flex items-center">
      <i class="fas fa-star mr-1"></i>
      <p>{{ liked_count }}</p>
    </div>
    <div v-else :class="optionByState(state_number).class" class="rotated h-12 w-24 border-t-4 border-white text-center absolute -right-12 -bottom-4">
      <p class="text-sm font-bold mt-1">{{ optionByState(state_number).text }}</p>
    </div>
  </section>
</template>

<script>
export default {
  data(){
    return {
      options: [
        { id: 0, text: this.$t("blog.options.draft"), class: "bg-blue-800" },
        { id: 1, text: this.$t("blog.options.limited"), class: "bg-green-800" }
      ]
    }
  },
  props: {
    state_number: {
      type: Number,
      default: 0,
      required: true
    },
    is_liked: {
      type: Boolean,
      default: false,
      required: true
    },
    liked_count: {
      type: Number,
      default: 0,
      required: true
    },
  },
  methods: {
    optionByState(state_number){
      return this.options.find((item) => item.id === state_number)
    },
    liked(is_liked){
      return is_liked ? "text-yellow-300" : "text-white"
    }
  }
}
</script>

<style scoped>
.rotated {
  transform: rotate(-45deg);
  -moz-transform: rotate(-45deg);
  -webkit-transform: rotate(-45deg);
}
</style>
