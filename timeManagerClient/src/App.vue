<script setup>
import UserComponent from "./components/UserComponent.vue";
import SideBar from "./components/SideBar.vue";
import ClockManager from "./components/ClockManager.vue";
import WorkingTimes from "./components/WorkingTimes.vue";
</script>

<template>
  <header></header>
  <div style="display: flex">
    <SideBar></SideBar>
    <div style="margin: 16px">
      <UserComponent></UserComponent>
      <ClockManager userid="1"></ClockManager>
      <WorkingTimes></WorkingTimes>
    </div>
  </div>
</template>

<style scoped>

</style>
