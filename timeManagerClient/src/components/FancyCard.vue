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
  background: var(--color-background-soft);
  border-radius: 8px;
  box-shadow: 4px 4px 6px #11111166;
  padding-bottom: 8px;
  margin: 0px 0px 16px 0px;
}

.card .fancy-stripe {
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
  background: linear-gradient(
    323deg,
    var(--color-secondary-shade) 0%,
    var(--color-primary-shade) 100%
  );
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
}

.card .content .center {
  text-align: center;
}

.card .important {
  font-weight: 900;
  color: green;
}
</style>
