<template>
  <v-form
    @submit.prevent="handleSubmit"
    ref="form"
    validate-on="blur"
    v-model="correct"
  >
    <concentrated-layout title="Welcome to Chatter.io">
      <template #default>
        <v-text-field
          color="primary"
          class="mb-2"
          name="username"
          v-model="username"
          label="Username"
          :rules="[requireRule]"
        ></v-text-field>
        <v-text-field
          color="primary"
          class="mb-2"
          v-model="email"
          name="email"
          label="E-mail"
          type="email"
          :rules="[requireRule, emailRule]"
        ></v-text-field>
        <v-text-field
          color="primary"
          class="mb-2"
          name="password"
          v-model="password"
          label="Password"
          type="password"
          :rules="[requireRule]"
        ></v-text-field>
        <v-text-field
          color="primary"
          class="mb-2"
          name="repeatedPassword"
          v-model="repeatedPassword"
          label="Repeated password"
          type="password"
          :rules="[requireRule, matchRule]"
        ></v-text-field>
        <v-checkbox
          color="primary"
          class="mb-2"
          v-model="agree"
          label="Agree to the terms of use"
          :rules="[checkedRule]"
        ></v-checkbox></template
      ><template #actions
        ><div class="d-flex">
          <v-btn color="primary" type="submit" class="mr-3">Sign up</v-btn>
          <link-to to="/login"> <v-btn>Back to login</v-btn></link-to>
        </div>
      </template>
    </concentrated-layout></v-form
  >
</template>

<script setup>
import { watch, ref } from "vue";
import { register } from "../service/auth.js";
import { useRouter } from "vue-router";
import {
  VTextField,
  VBtn,
  VCheckbox,
  VContainer,
  VRow,
  VCol,
  VForm,
} from "vuetify/components";
import { useSnackbarStore } from "../store/snackbarStore";
import ConcentratedLayout from "./ConcentratedLayout.vue";
import LinkTo from "./LinkTo.vue";
import {
  requireRule,
  checkedRule,
  emailRule,
  createMatchRule,
} from "../validation/rules";
import { computed } from "@vue/reactivity";

const snackbars = useSnackbarStore();
const router = useRouter();
const username = ref("");
const password = ref("");
const repeatedPassword = ref("");
const email = ref("");
const agree = ref(false);
const correct = ref(false);
const form = ref(null);

const matchRule = computed(() => createMatchRule(password.value, "password"));

const handleSubmit = async () => {
  if (!correct.value) return;
  const user = {
    username: username.value,
    password: password.value,
    email: email.value,
  };
  try {
    await register(user);
    snackbars.pushSnackbar({
      title: "Success",
      color: "green",
      message: "You've signed up successfully",
    });
  } catch (error) {
    snackbars.pushSnackbar({
      title: "Error",
      color: "red",
      message: `There was a problem with your sign-up:\n ${error}`,
    });
    return;
  }
  router.push("/login");
};
</script>

<style scoped></style>
