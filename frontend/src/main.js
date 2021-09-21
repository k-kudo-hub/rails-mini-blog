import { createApp } from 'vue'
import { createRouter, createWebHistory } from 'vue-router'
import { csrfToken } from 'rails-ujs'
import App from './App.vue'
import axios from 'axios'
import i18n from './plugins/i18n'
import routes from './plugins/router.js'
import './index.css'

const router = createRouter({
  history: createWebHistory(),
  routes: routes
});

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken()
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'
axios.defaults.withCredentials = true

const app = createApp(App)
app.use(i18n)
app.use(router)
app.mount('#app')
