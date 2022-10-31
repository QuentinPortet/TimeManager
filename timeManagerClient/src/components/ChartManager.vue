<script>
import axios from "axios";
import FancyCard from "./FancyCard.vue";
import { DoughnutChart, LineChart, BarChart } from "vue-chart-3";
import { Chart, registerables } from "chart.js";
import moment from "moment";

Chart.register(...registerables);

export default {
  components: {
    FancyCard,
    DoughnutChart,
    LineChart,
    BarChart,
  },
  data() {
    return {
      info: null,
      username: "",
      email: "",
      userId: 0,
      userClocks: [],
      diffLastClock: 0,
      doughnutData: {
        labels: ["Time worked", "Time left"],
        datasets: [
          {
            data: [0, 28800000],
            borderColor: ["#0dff86", "#09a3a1"],
            backgroundColor: ["#0dff8630", "#09a3a130"],
            borderWidth: 1,
          },
        ],
      },
      barsData: {
        labels: ["Sales", "Developers", "Marketing", "Administration"],
        datasets: [
          {
            label: "Percentage of burnouts this month",
            data: [6, 70, 4, 2],
            backgroundColor: ["#09a3a130"],
            borderColor: ["#09a3a1"],
            borderWidth: 1,
          },
        ],
      },
      lineData: {
        labels: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
        datasets: [
          {
            label: "Average work time per day",
            data: [7, 7.2, 7.6, 6.5, 6.8],
            fill: true,
            borderColor: "#0dff86",
            backgroundColor: "#0dff8630",
            borderWidth: 1,
            tension: 0.1,
          },
        ],
      },
    };
  },
  mounted() {
    this.getUser();
    this.getUserClocks();
  },
  computed: {
    doughData: function () {
      console.log("pourquoi ça marche po", this.doughnutData);
      return this.doughnutData;
    },
  },
  methods: {
    async getUserClocks() {
      await axios.get("http://localhost:4000/api/clocks/1").then((response) => {
        this.userClocks = response.data.data;
      });
      this.fillDatasets();
    },
    getUser() {
      axios.get("http://localhost:4000/api/users/1").then((response) => {
        this.username = response.data.data.username;
        this.email = response.data.data.email;
        this.userId = response.data.data.id;
      });
    },
    fillDatasets() {
      this.diffLastClock = moment().diff(
        moment(this.userClocks[this.userClocks.length - 1].time)
      );
      console.log("test", this.diffLastClock);
      this.doughnutData.datasets.data = [
        this.diffLastClock,
        28800000 - this.diffLastClock,
      ];
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
            <DoughnutChart :chartData="doughData" />
          </template>
        </FancyCard>
         <FancyCard>
          <template #header>Daily objective</template>
          <template #mainpart>
            <BarChart :chartData="barsData" />
          </template>
        </FancyCard>
      </div>
      <div style="display: flex; justify-content: space-around">
        <FancyCard :stripe="false" style="width: 100%">
          <template #header>Work time per day</template>
          <template #mainpart>
            <LineChart :chartData="lineData" />
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
