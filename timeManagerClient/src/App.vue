<script setup>
import UserComponent from "./components/UserComponent.vue";
import SideBar from "./components/SideBar.vue";
import ClockManager from "./components/ClockManager.vue";
import WorkingTimes from "./components/WorkingTimes.vue";
import ChartManager from "./components/ChartManager.vue";
import WorkingTime from "./components/WorkingTime.vue";
</script>

<template>
  <header></header>
  <div style="display: flex; width: 100%;">
    <SideBar style="z-index: 10;">
      <UserComponent userid="1"></UserComponent>
      <ClockManager userid="1" style="margin: 16px"></ClockManager>
    </SideBar>
    <div class="card-container">
      <div style="margin: 16px; display: flex; justify-content: space-around">
        <ChartManager></ChartManager>
      </div>
      <div style="margin: 16px; display: flex; justify-content: space-around">
        <WorkingTimes userid="1"></WorkingTimes>
        <WorkingTime userid="1"></WorkingTime>
      </div>
    </div>
  </div>
</template>

<style scoped></style>
