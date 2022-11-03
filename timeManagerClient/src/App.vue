<script setup>
import UserComponent from "./components/UserComponent.vue";
import SideBar from "./components/SideBar.vue";
import ClockManager from "./components/ClockManager.vue";
import WorkingTimes from "./components/WorkingTimes.vue";
import ChartManager from "./components/ChartManager.vue";
import WorkingTime from "./components/WorkingTime.vue";
import FancyButton from "./components/FancyButton.vue";
import FancyCard from "./components/FancyCard.vue";
</script>

<script>

export default {
  data() {
    return {
      userid: "",
      showLogin: true,
    }
  },
  components: { FancyButton, FancyCard }
};
</script>


<template>
  <header></header>
  <div v-if='this.userid == ""'>
    <h1>You're not connected</h1>
    <FancyButton @click="this.showLogin = true">Login</FancyButton>
  </div>
  <div style="display: flex; width: 100%">
    <SideBar style="z-index: 10">
      <UserComponent userid="" :isuseradmin="false"></UserComponent>
      <ClockManager userid="" style="margin: 16px"></ClockManager>
    </SideBar>
    <div class="card-container">
      <div style="
          margin: 16px;
          display: flex;
          justify-content: space-between;
          width: 150vh;
        ">
        <ChartManager userid=""></ChartManager>
      </div>
      <div style="
          margin: 16px;
          display: flex;
          justify-content: space-between;
          width: 150vh;
        ">
        <WorkingTimes userid=""></WorkingTimes>
        <WorkingTime userid=""></WorkingTime>
      </div>
    </div>
  </div>
  <vue-final-modal v-model="showLogin" classes="modal-container" content-class="modal-content">
    <FancyCard>
      <template #header>Login</template>
      <template #mainpart>
        <form>
          <label>email</label><br>
          <input id="mail" type="text" v-model="username" /><br />
          <label>password</label><br>
          <input id="password" type="password" v-model="email" /><br />
          <FancyButton color="green" @click="connect($event)">Login</FancyButton>
        </form>
      </template>
    </FancyCard>
  </vue-final-modal>
</template>

<style scoped>

</style>
