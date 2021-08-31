import Home from './components/Home.vue'
import Profile from './components/users/Profile.vue'
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
  }
]
export default routes
