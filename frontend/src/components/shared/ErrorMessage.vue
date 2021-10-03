<template>
  <div v-if="errors.length > 0">
    <p v-for="(item, index) in errors" :key="index" class="text-red-500">{{ item }}</p>
  </div>
</template>

<script>
export default {
  props: {
    errors: Array,
  }
}
</script>
