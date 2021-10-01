<template>
  <article class="mb-3 border-b">
    <div class="markdown" v-html="compileMarkdown"></div>
  </article>
</template>

<script>
import markdownIt from 'markdown-it'
import hljs       from 'highlight.js'
import sanitizer  from 'markdown-it-sanitizer'
import emoji      from 'markdown-it-emoji'
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
      })
      .use(sanitizer)
      .use(emoji)
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
.markdown > * {
  margin-bottom: 0.2rem;
}
.markdown h1 {
  font-size: 1.2rem;
  font-weight: 800;
  margin-bottom: 1rem;
}
.markdown h2 {
  font-size: 1.2rem;
  font-weight: 700;
  margin-bottom: 1rem;
}
.markdown h3 {
  font-size: 1.2rem;
  font-weight: 600
}
.markdown h4 {
  font-size: 1.1rem;
  font-weight: 600;
}
.markdown pre {
  background-color: rgb(255, 252, 220);
  padding: 10px 5px;
  margin-bottom: 1rem;
  overflow-x: scroll;
}
.markdown p {
  margin-bottom: 1rem;
  line-height: 1.8;
}
.markdown li {
  list-style: inside;
  line-height: 2;
}
.markdown li li {
  margin-left: 2rem;
}
.markdown a {
  color: blue;
  text-decoration: underline;
}
.markdown a:visited {
  color: rgb(138, 0, 162);
  text-decoration: underline;
}
</style>
