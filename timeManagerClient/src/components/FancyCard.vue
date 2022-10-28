<script>
export default {
  props: {
    stripe: {
      type: Boolean,
      default: true,
    },
  },
};
</script>

<template>
  <div class="card">
    <div v-if="stripe === true" class="fancy-stripe"></div>
    <div class="header">
      <slot name="header">Oops, something bad happened</slot>
    </div>
    <div class="content">
      <slot name="mainpart">Oops, something bad happened</slot>
    </div>
  </div>
</template>

<style>
.card {
  margin: 7%;
  background: var(--color-background-soft);
  border-radius: 8px;
  box-shadow: 4px 4px 6px #11111166;
  padding-bottom: 8px;
  max-width: 80vw;
  margin: 0px 0px 16px 0px;
}

.card .fancy-stripe {
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
  background: linear-gradient(323deg, #1a302a 0%, #09a3a1 100%);
  width: 100%;
  height: 16px;
}

.card .header {
  margin: 8px;
  font-weight: 900;
  font-size: 20px;
}

.card .content {
  margin: 8px;
}

.card button {
  margin-top: 5%;
  padding: 10px;
  background-color: #2c3e50;
  border-radius: 5px;
  border-color: transparent;
}

.card .content .center {
  text-align: center;
}

.card .important {
  font-weight: 900;
  color: green;
}
</style>
