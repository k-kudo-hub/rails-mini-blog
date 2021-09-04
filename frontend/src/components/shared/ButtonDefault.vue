<template>
  <button type="submit" class="border border-gold-500 text-gold-500 hover:text-white bg-white hover:bg-gold-500 py-1 px-2 rounded-2xl shadow-md">{{ text }}</button>
</template>

<script>
export default {
  props: {
    text: "",
  }
}
</script>
