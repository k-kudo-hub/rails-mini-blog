import Home         from '../components/Home.vue'
import BlogEdit     from '../components/blogs/BlogEdit.vue'
import BlogShow     from '../components/blogs/BlogShow.vue'
import BlogIndex    from '../components/blogs/BlogIndex.vue'
import Profile      from '../components/users/Profile.vue'
import Registration from '../components/sessions/Registration.vue'
import Login        from '../components/sessions/Login.vue'
import BlogCreate   from '../components/blogs/BlogCreate.vue'
const routes = [
  {
    component: BlogIndex,
    name: 'home',
    path: '/'
  },
  {
    component: BlogCreate,
    name: 'blog_create',
    path: '/blog'
  },
  {
    component: BlogEdit,
    name: 'blog_edit',
    path: '/blogs/:url/edit'
  },
  {
    component: BlogShow,
    name: 'blog_show',
    path: '/blogs/:url'
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
