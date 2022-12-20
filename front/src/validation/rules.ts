import { emailRegexp } from "./regexp";

export const requireRule = (v) => !!v || "Field is required";
export const createMatchRule = (toMatch, fieldName) => (v) =>
  v === toMatch || `Field should be the same as ${fieldName}`;
export const emailRule = (v) =>
  v.match(emailRegexp) || "Field is not a vaild email";
export const checkedRule = (v) => v === true || "Field has to be checked";
