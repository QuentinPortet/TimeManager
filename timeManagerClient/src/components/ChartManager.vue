<script setup>
defineProps({
  userid: {
    type: String,
    required: true,
  },
});
</script>

<script>
import FancyCard from "./FancyCard.vue";
import { DoughnutChart, LineChart, BarChart } from "vue-chart-3";
import { Chart, registerables } from "chart.js";
import axios from "axios";
import { parseStringStyle } from "@vue/shared";
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
      weekWorkingTimes: null,
      doughnutData: {
        labels: ["Current working time", "Daily objective"],
        datasets: [
          {
            data: [23, 77],
            borderColor: ["#09a3a1", "#0dff86"],
            backgroundColor: ["#09a3a130", "#0dff8630"],
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
    getWorkingTimeWeek() {
      let date = new Date(Date.now());
      let dateMinus7 = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);

      axios
        .get("http://localhost:4000/api/workingtimes/" + this.userid, {
          params: { start: dateMinus7, end: date },
          header: "Access-Control-Allow-Origin: *",
        })
        .then((response) => {
          let data = response.data.data;
          this.weekWorkingTimes = {
            Monday: 0,
            Tuesday: 0,
            Wednesday: 0,
            Thursday: 0,
            Friday: 0,
            Saturday: 0,
            Sunday: 0,
          };
          for (let i = 0; i < data.length; i++) {
            let day = moment(data[i].start).format("dddd");
            this.weekWorkingTimes[day] +=
              new Date(data[i].end) - new Date(data[i].start);
          }
          console.log(this.weekWorkingTimes);
        })
        .catch((error) => {
          console.log(error);
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
  mounted() {
    this.generateFakeWorkingTime();
    this.getWorkingTimeWeek();
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
        <FancyCard :stripe="false" style="width: 50%">
          <template #header>Exhaustion</template>
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
