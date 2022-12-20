<script setup>
import SnackbarsDisplay from "./components/SnackbarsDisplay.vue";
import colors from "vuetify/lib/util/colors";
import { getUser } from "./service/auth";
import { useRouter } from "vue-router";
import { VApp } from "vuetify/components";

const router = useRouter();
try {
  getUser();
} catch (e) {
  e.STATUS_CODE === 401 ? localStorage.removeItem("token") : console.log(e);
  router.push("/login");
}
</script>

<template>
  <v-app> <router-view /></v-app>
  <snackbars-display />
</template>

<style>
#app {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  min-height: 100vh;
}
</style>
