<template>
  <v-app-bar>
    <v-toolbar color="primary" :style="{ width: '100%' }">
      <v-toolbar-title class="text-h4 font-weight-bold"
        >Chatter.io</v-toolbar-title
      >
      <v-spacer></v-spacer>
      <v-btn color="white" variant="outlined" class="ml-3" @click="logout"
        >Logout</v-btn
      >
    </v-toolbar>
  </v-app-bar>
</template>

<script setup>
import { VAppBar, VToolbar, VBtn, VToolbarTitle } from "vuetify/components";
import { useRouter } from "vue-router";
import { useUserStore } from "../store/userStore";

const userStore = useUserStore();
const router = useRouter();
const logout = () => {
  userStore.setToken = null;
  userStore.setUser = null;
  localStorage.removeItem("token");
  router.push("/login");
  window.location.reload();
};
</script>

<style></style>
