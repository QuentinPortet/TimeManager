<script>
export default {
  props: {
    color: {
      type: String,
      default: "default",
    },
  },
};
</script>

<template>
  <button :class="color === 'danger' ? 'fancy-button-danger' : 'fancy-button'">
    <slot>Oops</slot>
  </button>
</template>

<style>
.fancy-button {
  background: var(--color-primary-shade);
  min-width: 150px;
  height: 32px;
  border-radius: 8px;
  border-color: transparent;
  text-align: center;
  cursor: pointer;
  color: white;
  padding: 0px !important;
  padding-left: 6px !important;
  padding-right: 6px !important;
  font-weight: 600;
  box-shadow: 4px 4px 6px #11111166;
  transition: all 1s;
}
.fancy-button:hover {
  background: var(--color-secondary-shade) !important;
}
.fancy-button-danger {
  background: var(--color-danger-shade);
  min-width: 150px;
  height: 32px;
  border-radius: 8px;
  border-color: transparent;
  text-align: center;
  cursor: pointer;
  color: white;
  padding: 0px !important;
  padding-left: 6px !important;
  padding-right: 6px !important;
  font-weight: 600;
  box-shadow: 4px 4px 6px #11111166;
  transition: all 0.5s;
}
.fancy-button-danger:hover {
  background: var(--color-danger) !important;
}
</style>
