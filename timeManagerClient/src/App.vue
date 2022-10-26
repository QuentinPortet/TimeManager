<script setup>
import UserComponent from "./components/UserComponent.vue";
import TopBar from "./components/TopBar.vue";
import ClockManager from "./components/ClockManager.vue";
</script>

<template>
  <header>
    <TopBar></TopBar>
    <div style="margin: 16px">
      <UserComponent></UserComponent>
      <ClockManager></ClockManager>
    </div>
  </header>
</template>

<style scoped></style>
