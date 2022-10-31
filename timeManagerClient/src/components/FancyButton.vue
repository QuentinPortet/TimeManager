<script>
export default {
  props: {
    color: {
      type: String,
      required: false,
    },
  },
};
</script>

<template>
  <button class="fancy-button" :style="color ? 'background: ' + color : ''">
    <slot>Oops</slot>
  </button>
</template>

<style>
.fancy-button {
  background: linear-gradient(
    323deg,
    rgb(132, 156, 0) 0%,
    rgb(101, 145, 0) 100%
  );
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
}
</style>
