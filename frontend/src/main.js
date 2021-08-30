import { createApp } from 'vue'
import { createI18n } from 'vue-i18n'
import ja_file from './lang/ja'
import en_file from './lang/en'
import App from './App.vue'
import './index.css'

const messages = {
  en: en_file,
  ja: ja_file
}

const i18n = createI18n({
  locale: 'ja',
  messages,
})

const app = createApp(App)

app.use(i18n).mount('#app')
