import _ from 'lodash';
import Vue from 'vue';
import VueRouter from 'vue-router'
import VueMaterial from 'vue-material'
import router from './routes'
import './scss/main.scss'

Vue.config.devtools = false;
Vue.config.productionTip = false;
Vue.use(VueRouter)
Vue.use(VueMaterial)

const App = new Vue({
    el: 'div.app',
    router,
});