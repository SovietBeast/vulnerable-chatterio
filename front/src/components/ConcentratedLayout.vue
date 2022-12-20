<template>
  <main class="bg-grey-lighten-2">
    <v-container class="bg-blue-grey-lighten-5 py-10 layout-container"
      ><h1 class="text-h-1 text-black mb-3">
        {{ title }}
      </h1>
      <hr class="mb-5" />
      <v-row align="center"
        ><v-col><slot></slot></v-col>
        <v-col> <img src="./icons/icon.png" class="icon" /></v-col>
      </v-row>
      <hr class="mb-5" />
      <slot name="actions"></slot>
    </v-container>
  </main>
</template>
<script setup>
import { VContainer, VRow, VCol } from "vuetify/components";
defineProps(["title"]);
</script>
<style scoped>
main {
  width: 100vw;
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
h1 {
  font-family: "Verdana";
  font-weight: 700;
}
.layout-container {
  -webkit-box-shadow: 9px 21px 41px -6px rgba(66, 68, 90, 1);
  -moz-box-shadow: 9px 21px 41px -6px rgba(66, 68, 90, 1);
  box-shadow: 9px 21px 41px -6px rgba(66, 68, 90, 1);
  width: 40vw;
  padding-left: 22px;
  padding-right: 22px;
  border-radius: 10px;
}
.icon {
  user-select: none;
  width: 80%;
  object-fit: contain;
}
</style>
