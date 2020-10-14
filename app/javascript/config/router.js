import Vue from 'vue'
import History from '../components/history'
import Ships from '../components/ships'
import VueRouter from 'vue-router'

Vue.use(VueRouter);

const routes = [
  { path: '/ships', component: Ships },
  { path: '/', component: History }
]

// 3. Create the router instance and pass the `routes` option
// You can pass in additional options here, but let's
// keep it simple for now.
export default new VueRouter({
  routes // short for `routes: routes`
})
