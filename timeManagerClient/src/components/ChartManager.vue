<script>
import axios from "axios";
import moment from "moment";
import FancyCard from "./FancyCard.vue";
import BarChart from "./BarChart.vue";
import DoughnutChart from "./DoughnutChart.vue";
import LineChart from "./LineChart.vue";

export default {
  components: {
    FancyCard,
    BarChart,
    DoughnutChart,
    LineChart,
  },
  data() {
    return {
      info: null,
      username: "",
      email: "",
      userId: 0,
      userClocks: [],
      diffLastClock: 0,
      doughData: {
        labels: ["January", "February", "March"],
        datasets: [{ data: [40, 20, 12] }],
      },
    };
  },
  mounted() {
    this.getUser();
    this.getUserClocks();
  },
  methods: {
    async getUserClocks() {
      await axios.get("http://localhost:4000/api/clocks/1").then((response) => {
        this.userClocks = response.data.data;
      });
    },
    getUser() {
      axios.get("http://localhost:4000/api/users/1").then((response) => {
        this.username = response.data.data.username;
        this.email = response.data.data.email;
        this.userId = response.data.data.id;
      });
    },
    changeData() {
      this.doughData.datasets[0].data = [10, 10, 10];
    },
  },
};
</script>

<template>
  <FancyCard>
    <template #header>Metrics</template>
    <template #mainpart>
      <div style="display: flex; justify-content: space-around">
        <FancyCard :stripe="false" style="width: 50%">
          <template #header>Daily objective</template>
          <template #mainpart>
            <DoughnutChart></DoughnutChart>
          </template>
        </FancyCard>
        <FancyCard :stripe="false">
          <template #header>Cool bars</template>
          <template #mainpart>
            <BarChart :chartData="doughData"></BarChart>
            <button @click="changeData"></button>
          </template>
        </FancyCard>
      </div>
      <div style="display: flex; justify-content: space-around">
        <FancyCard :stripe="false" style="width: 100%">
          <template #header>Work time per day</template>
          <template #mainpart>
            <LineChart></LineChart>
          </template>
        </FancyCard>
      </div>
    </template>
  </FancyCard>
</template>

<style>
.hidden-scrollbar::-webkit-scrollbar {
  display: none;
}

.hidden-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
</style>
