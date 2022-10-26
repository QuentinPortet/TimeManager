<script setup>
import UserComponent from "./components/UserComponent.vue";
import TopBar from "./components/TopBar.vue";
</script>

<template>
  <header>
    <TopBar></TopBar>
    <div style="margin: 16px">
      <UserComponent></UserComponent>
    </div>
  </header>
</template>

<style scoped></style>
