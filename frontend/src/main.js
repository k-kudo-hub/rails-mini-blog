import { createApp } from 'vue'
import { createI18n } from 'vue-i18n/index'
import { createRouter, createWebHistory } from 'vue-router'
import ja_file from './lang/ja'
import en_file from './lang/en'
import App from './App.vue'

import routes from './router.js'
import './index.css'

const messages = {
  en: en_file,
  ja: ja_file
}

const i18n = createI18n({
  locale: 'ja',
  messages,
})

const router = createRouter({
  history: createWebHistory(),
  routes: routes
});

const app = createApp(App)
app.use(i18n)
app.use(router)
app.mount('#app')
