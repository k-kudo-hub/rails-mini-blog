<template>
  <button type="submit" class="border border-gold-500 text-white hover:text-gold-500 bg-gold-500 hover:bg-white py-1 px-3 rounded-2xl shadow-md">{{ text }}</button>
</template>

<script>
export default {
  props: {
    text: "",
  }
}
</script>
