<template>
  <v-snackbar
    v-for="(snackbar, index) in currentSnackbars"
    :key="snackbar.id"
    location="bottom right"
    :timeout="8000"
    rounded
    vertical
    max-width="380px"
    height="165px"
    :style="{ bottom: `${index * 180 + 15}px`, top: 'unset' }"
    transition="fab-transition"
    v-model="snackbar.active"
    :color="snackbar.color"
    multi-line
  >
    <div class="text-h5" :style="{ marginBottom: '5px' }">
      {{ snackbar.title }}
    </div>
    <div class="text-body-2" :style="{ overflow: 'hidden', maxHeight: '100%' }">
      {{ snackbar.message }}
    </div>
    <template v-slot:actions>
      <v-btn
        color="red-lighten-7"
        variant="tonal"
        @click="snackbar.active = false"
      >
        Close
      </v-btn></template
    >
  </v-snackbar>
</template>

<script>
import { defineComponent, ref } from "vue";
import { VSnackbar, VBtn } from "vuetify/components";
import { useSnackbarStore } from "../store/snackbarStore";

export default defineComponent({
  components: {
    VSnackbar,
    VBtn,
  },
  setup() {
    const currentSnackbars = ref([]);
    const snackbars = useSnackbarStore();
    snackbars.$onAction(({ name, args }) => {
      if (name === "pushSnackbar") {
        const queue = args;
        currentSnackbars.value.push(
          ...queue.map((s) => ({ ...s, active: true }))
        );
        snackbars.flushSnackbars();
        setTimeout(() => {
          currentSnackbars.value.splice(0, 1);
        }, 8200);
      }
    });

    return { currentSnackbars };
  },
});
</script>

<style>
.v-snackbar__wrapper {
  min-width: unset;
  height: 100%;
}
</style>
