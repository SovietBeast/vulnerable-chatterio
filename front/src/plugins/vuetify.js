// Styles
import "@mdi/font/css/materialdesignicons.css";
import "vuetify/styles";
import colors from "vuetify/lib/util/colors";
import { createVuetify } from "vuetify";
import { aliases, mdi } from "vuetify/iconsets/mdi";

export const primary = colors.lightBlue.base;
export const secondary = colors.lightGreen.darken3;
export const error = colors.red.base;

export default createVuetify({
  icons: {
    defaultSet: "mdi",
    aliases,
    sets: {
      mdi,
    },
  },
  theme: {
    defaultTheme: "light",
    variations: {
      colors: ["primary", "secondary"],
      lighten: 3,
      darken: 3,
    },
    themes: {
      light: {
        dark: false,
        colors: {
          primary,
          secondary,
          error,
        },
      },
    },
  },
});
