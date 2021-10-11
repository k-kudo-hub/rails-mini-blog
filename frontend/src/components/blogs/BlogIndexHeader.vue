<template>
  <div class="flex items-center justify-around mb-2 mx-2 pb-2">
    <button
      v-for="option in options"
      :key="option.id"
      :class="setBorder(option.name)"
      class="border-b-2 w-1/3 mx-1"
      @click="$emit(option.method)">
    {{ option.text }}
    </button>
  </div>
</template>

<script>
export default {
  data(){
    return {
      options: [
        { id: 0, name: 'latest', method: 'getBlogs', text: this.$t("star.options.latest") },
        { id: 1, name: 'stars', method: 'getStars', text: this.$t("star.options.stars") },
        { id: 2, name: 'higher_rating', method: 'getHigherRating', text: this.$t("star.options.higher_rating") }
      ]
    }
  },
  props: {
    currentBlogs: {
      type: String,
      default: 'latest',
      required: true,
    }
  },
  methods: {
    setBorder(pattern){
      return this.currentBlogs === pattern ? "border-yellow-300" : "border-gray-100"
    }
  }
}
</script>
