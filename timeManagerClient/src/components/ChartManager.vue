<script>
import FancyCard from "./FancyCard.vue";
import { DoughnutChart, LineChart, BarChart } from "vue-chart-3";
import { Chart, registerables } from "chart.js";

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
    this.generateFakeWorkingTime();
  },
  methods: {
    generateFakeWorkingTime() {
      const days = Math.floor(Math.random() * 99);
      const hours = Math.floor(Math.random() * 23);

      return days.toString() + "d, " + hours.toString() + "h";
    },
  },
};
</script>

<template>
  <FancyCard>
    <template #header>Metrics</template>
    <template #mainpart>
      <div style="display: flex; justify-content: space-around">
        <FancyCard stripe="false" style="width: 50%">
          <template #header>Daily objective</template>
          <template #mainpart>
            <DoughnutChart :chartData="doughnutData" />
          </template>
        </FancyCard>
        <FancyCard stripe="false" style="width: 50%">
          <template #header>Exhaustion</template>
          <template #mainpart>
            <BarChart :chartData="barsData" />
          </template>
        </FancyCard>
      </div>
      <div style="display: flex; justify-content: space-around">
        <FancyCard stripe="false" style="width: 100%">
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
