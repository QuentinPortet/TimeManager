<script setup>
defineProps({
  userid: {
    type: String,
    required: true,
  },
});
</script>

<script>
import axios from "axios";
import moment from "moment";
import FancyCard from "./FancyCard.vue";
import BarChart from "./BarChart.vue";
import DoughnutChart from "./DoughnutChart.vue";
import LineChart from "./LineChart.vue";
import { parseStringStyle } from "@vue/shared";

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
      barsData: {
        labels: ["January", "February", "March"],
        datasets: [
          {
            label: "Quelque chose",
            data: [40, 20, 12],
            backgroundColor: ["#09a3a120"],
            borderColor: ["#09a3a1"],
            borderWidth: 1,
          },
        ],
      },
      doughData: {
        labels: ["Red", "Blue"],
        datasets: [
          {
            label: "My First Dataset",
            data: [50, 300],
            backgroundColor: ["#0dff8620", "#09a3a120"],
            borderColor: ["#0dff8620", "#09a3a120"],
            borderWidth: 1,
          },
        ],
      },
      lineData: {
        labels: [
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday",
        ],
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
    async getWorkingTimeWeek() {
      let date = new Date(Date.now());
      let dateMinus7 = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000);
      try {
        let res = await axios.get(
          "http://localhost:4000/api/workingtimes/" + this.userid,
          {
            params: { start: dateMinus7, end: date },
            header: "Access-Control-Allow-Origin: *",
          }
        );
        if (res.status == 200) {
          let data = res.data.data;
          let weekWork = {
            Monday: 0,
            Tuesday: 0,
            Wednesday: 0,
            Thursday: 0,
            Friday: 0,
            Saturday: 0,
            Sunday: 0,
          };
          console.log(data.length);
          for (let i = 0; i < data.length; i++) {
            let day = moment(data[i].start).format("dddd");
            console.log(new Date(data[i].end) - new Date(data[i].start));
            weekWork[day] += new Date(data[i].end) - new Date(data[i].start);
          }
          return weekWork;
        }
      } catch (err) {
        console.log(err);
      }
    },
    changeData() {
      this.getWorkingTimeWeek().then((weekWork) => {
        console.log(weekWork);
        this.lineData.datasets[0].data = [
          weekWork.Monday,
          weekWork.Tuesday,
          weekWork.Wednesday,
          weekWork.Thursday,
          weekWork.Friday,
          weekWork.Saturday,
          weekWork.Sunday,
        ];
      });
      this.doughData.datasets[0].data = [30, 10];
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
            <DoughnutChart :chartData="doughData"></DoughnutChart>
          </template>
        </FancyCard>
        <FancyCard :stripe="false">
          <template #header>Cool bars</template>
          <template #mainpart>
            <BarChart :chartData="barsData"></BarChart>
            <button @click="changeData"></button>
          </template>
        </FancyCard>
      </div>
      <div style="display: flex; justify-content: space-around">
        <FancyCard :stripe="false" style="width: 100%">
          <template #header>Work time per day</template>
          <template #mainpart>
            <LineChart :chartData="lineData"></LineChart>
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
