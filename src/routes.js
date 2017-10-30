import VueRouter from 'vue-router'
import example from './vue/example.vue'

var router = new VueRouter({
    routes: [
        {
            path: '/', component: example
        }
    ]
});

export default router