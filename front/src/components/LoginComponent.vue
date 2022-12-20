<template>
  <v-form
    @submit.prevent="loginHandler"
    ref="form"
    validate-on="blur"
    v-model="correct"
  >
    <concentrated-layout title="Login">
      <template #default>
        <v-text-field
          v-model="username"
          name="username"
          color="primary"
          label="Username"
          class="mb-2"
          @submit="loginHandler"
          :rules="[requireRule]"
        ></v-text-field>
        <v-text-field
          color="primary"
          v-model="password"
          label="Password"
          type="password"
          name="password"
          class="mb-2"
          @submit="loginHandler"
          :rules="[requireRule]"
        ></v-text-field>
      </template>
      <template #actions>
        <v-btn color="primary" min-width="200px" type="submit" label="Log In"
          >Log In</v-btn
        >

      </template>
    </concentrated-layout></v-form
  >
</template>

<script setup>
import { defineComponent, ref } from "@vue/runtime-core";
import { login, getUser } from "../service/auth";
import ConcentratedLayout from "./ConcentratedLayout.vue";
import { useSnackbarStore } from "../store/snackbarStore";
import LinkTo from "./LinkTo.vue";
import { useRouter } from "vue-router";
import { VTextField, VBtn, VForm } from "vuetify/components";
import { requireRule } from "../validation/rules";

const snackbars = useSnackbarStore();
const router = useRouter();
const username = ref("");
const password = ref("");
const form = ref(null);
const correct = ref(false);

const loginHandler = async () => {
  if (!correct.value) return;
  const user = {
    username: username.value,
    password: password.value,
  };
  try {
    const { data } = await login(user);
    localStorage.setItem("token", `${data.access_token}`);
    const userData = await getUser();
    router.push("/");
    snackbars.pushSnackbar({
      title: `Welcome back ${userData.username}`,
      color: "green",
      message: "",
    });
  } catch (error) {
    snackbars.pushSnackbar({
      title: "Error",
      color: "red",
      message: `There was some issue with logging you:\n ${error}`,
    });
  }
};
</script>
<style scoped>
.smallText a {
  font-size: 12px;
  font-weight: 700;
}
</style>
