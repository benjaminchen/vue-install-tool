<template>
    <div class="container">
        <h1>Hello Vue!</h1>
        <md-bottom-bar>
            <md-bottom-bar-item md-icon="important_devices" v-on:click="gotoUrl('https://vuejs.org/')">Vue</md-bottom-bar-item>
            <md-bottom-bar-item md-icon="router" v-on:click="gotoUrl('https://router.vuejs.org/en/')">Route</md-bottom-bar-item>
            <md-bottom-bar-item md-icon="perm_device_information" v-on:click="gotoUrl('http://vuematerial.io')">Material</md-bottom-bar-item>
            <md-bottom-bar-item md-icon="near_me" v-on:click="gotoUrl('https://github.com/benjaminchen/vue-install-tool')">GITHUB</md-bottom-bar-item>
        </md-bottom-bar>
    </div>
</template>

<script>
    export default {
        methods: {
            gotoUrl(url) {
                window.location.href = url
            }
        }
    }
</script>