<script setup>
import UserComponent from "./components/UserComponent.vue";
import TopBar from "./components/TopBar.vue";
import ClockManager from "./components/ClockManager.vue";
import WorkingTimes from "./components/WorkingTimes.vue";
</script>

<template>
  <header>
    <TopBar></TopBar>
    <div style="margin: 16px">
      <UserComponent></UserComponent>
      <ClockManager userid="1"></ClockManager>
      <WorkingTimes></WorkingTimes>
    </div>
  </header>
</template>

<style scoped>

</style>
