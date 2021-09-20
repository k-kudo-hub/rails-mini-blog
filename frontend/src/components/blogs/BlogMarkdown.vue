<template>
  <div v-html="compileMarkdown"></div>
</template>

<script>
import markdownIt from 'markdown-it'
import hljs       from 'highlight.js'
export default {
  data() {
    return {
      markdownIt: new markdownIt({
          highlight: function(code, lang) {
              return hljs.highlightAuto(code, [lang]).value;
          },
          html: true,
          linkify: true,
          breaks: true,
          typographer: true
      }),
    }
  },
  props: {
    content: String,
  },
  computed: {
    compileMarkdown(){
      return this.markdownIt.render(this.content)
    }
  },
}

</script>

<style>

</style>
