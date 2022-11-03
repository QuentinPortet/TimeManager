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
import { Chart, Filler } from "chart.js";

Chart.register(Filler);

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
      lastClock: null,
      diffLastClock: 0,
      barsData: {
        labels: [
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday",
        ],
        datasets: [
          {
            label: "Work time",
            data: [40, 20, 12],
            backgroundColor: ["#09a3a120"],
            borderColor: ["#09a3a1"],
            borderWidth: 1,
          },
        ],
      },
      doughData: {
        labels: ["Done", "Remaining"],
        datasets: [
          {
            data: [100, 0],
            backgroundColor: ["#0dff8620", "#09a3a120"],
            borderColor: ["#0dff86", "#09a3a1"],
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
        datasets: [
          {
            label: "Quelque chose",
            data: [40, 20, 12],
            backgroundColor: ["#09a3a120"],
            borderColor: ["#09a3a1"],
            borderWidth: 1,
            fill: true,
          },
        ],
      },
    };
  },
  mounted() {
    this.getUser();
    this.getUserClocks();
    this.changeData();
  },
  methods: {
    async getUserClocks() {
      await axios.get("http://localhost:4000/api/clocks/1").then((response) => {
        this.userClocks = response.data.data;
        this.lastClock = this.userClocks[this.userClocks.length - 1].time;
        this.diffLastClock = moment().diff(moment(this.lastClock));
        this.doughData.datasets[0].data = [
          this.diffLastClock,
          28800000 - this.diffLastClock,
        ];
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
          for (let i = 0; i < data.length; i++) {
            let day = moment(data[i].start).format("dddd");
            weekWork[day] += new Date(data[i].end) - new Date(data[i].start);
          }
          for (let day in weekWork) {
            weekWork[day] = weekWork[day] / 1000 / 60 / 60;
          }
          return weekWork;
        }
      } catch (err) {
        console.log(err);
      }
    },
    async getWorkingTimeEver() {
      let date = new Date(Date.now());
      let epoch0 = new Date(0);
      try {
        let res = await axios.get(
          "http://localhost:4000/api/workingtimes/" + this.userid,
          {
            params: { start: epoch0, end: date },
            header: "Access-Control-Allow-Origin: *",
          }
        );
        if (res.status == 200) {
          let data = res.data.data;
          let dayCounter = {
            Monday: 0,
            Tuesday: 0,
            Wednesday: 0,
            Thursday: 0,
            Friday: 0,
            Saturday: 0,
            Sunday: 0,
          };
          let weekWork = {
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
            dayCounter[day] += 1;
            weekWork[day] += new Date(data[i].end) - new Date(data[i].start);
          }
          for (let i = 0; i < 7; i++) {
            weekWork[Object.keys(weekWork)[i]] /=
              dayCounter[Object.keys(dayCounter)[i]];
          }
          for (let day in weekWork) {
            weekWork[day] = weekWork[day] / 1000 / 60 / 60;
          }
          return weekWork;
        }
      } catch (err) {
        console.log(err);
      }
    },
    changeData() {
      this.getWorkingTimeWeek().then((weekWork) => {
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
      this.getWorkingTimeEver().then((weekWork) => {
        this.barsData.datasets[0].data = [
          weekWork.Monday,
          weekWork.Tuesday,
          weekWork.Wednesday,
          weekWork.Thursday,
          weekWork.Friday,
          weekWork.Saturday,
          weekWork.Sunday,
        ];
      });
    },
  },
};
</script>

<template>
  <FancyCard  v-if='this.userid != ""'>
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
          <template #header>Average work time per day</template>
          <template #mainpart>
            <BarChart :chartData="barsData"></BarChart>
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
