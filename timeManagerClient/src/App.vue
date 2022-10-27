<script setup>
import UserComponent from "./components/UserComponent.vue";
import SideBar from "./components/SideBar.vue";
import ClockManager from "./components/ClockManager.vue";
</script>

<template>
  <header></header>
  <div style="display: flex">
    <SideBar></SideBar>
    <div style="margin: 16px">
      <UserComponent></UserComponent>
      <ClockManager></ClockManager>
    </div>
  </div>
</template>

<style scoped></style>
