<script></script>

<template>
  <div class="bar"><slot></slot></div>
</template>

<style>
.bar {
  background: var(--color-background-soft);
  top: -16px;
  height: 100vh;
  width: 380px;
  box-shadow: 2px 2px 6px #11111166;
  position: -webkit-sticky;
  position: sticky;
  top: 0;
}
</style>
