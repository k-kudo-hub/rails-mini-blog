<template>
  <transition name="component-fade">
    <div v-if="hook" class="w-full fixed bottom-20 left-0">
      <p class="bg-gold-500 text-white w-3/4 p-2 z-50 rounded-3xl text-center mx-auto">{{ message }}</p>
    </div>
  </transition>
</template>

<script>
export default {
  props: {
    hook: {
      type: Boolean,
      default: false,
      required: true,
    },
    message: {
      type: String,
      default: "",
      required: true,
    },
  }
}
</script>

<style>
.component-fade-enter-active,
.component-fade-leave-active {
  transition: opacity .3s ease;
}
.component-fade-enter,
.component-fade-leave-to {
  opacity: 0;
}
</style>
