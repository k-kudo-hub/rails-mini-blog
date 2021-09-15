import Home from '../components/Home.vue'
import Profile from '../components/users/Profile.vue'
import Registration from '../components/sessions/Registration.vue'
import Login from '../components/sessions/Login.vue'
const routes = [
  {
    component: Home,
    name: 'home',
    path: '/'
  },
  {
    component: Profile,
    name: 'profile',
    path: '/profile'
  },
  {
    component: Registration,
    name: 'registration',
    path: '/registration'
  },
  {
    component: Login,
    name: 'login',
    path: '/login'
  }
]
export default routes
