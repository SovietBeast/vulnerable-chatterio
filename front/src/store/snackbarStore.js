import { defineStore } from "pinia";

export const useSnackbarStore = defineStore("snackbar", {
  state: () => {
    return {
      nextId: 0,
      snackbarsQueue: [], // {message: string, title: string, color: string}[]
    };
  },
  getters: {
    getQueue: (state) => state.snackbarsQueue,
  },
  actions: {
    pushSnackbar(snackbar) {
      this.snackbarsQueue.push({ ...snackbar, id: this.nextId });
      this.nextId++;
    },
    flushSnackbars() {
      this.snackbarsQueue = [];
    },
  },
});
