import { createApp } from 'vue'
import { createI18n } from 'vue-i18n/index'
import { createRouter, createWebHistory } from 'vue-router'
import { csrfToken } from 'rails-ujs'
import App from './App.vue'
import axios from 'axios'
import en_file from './lang/en'
import ja_file from './lang/ja'
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

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'

const app = createApp(App)
app.use(i18n)
app.use(router)
app.mount('#app')
