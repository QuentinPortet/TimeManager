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
import FancyCard from "./FancyCard.vue";
import FancyButton from "./FancyButton.vue";
export default {
  name: "ClockManager",
  components: {
    FancyCard,
    FancyButton,
  },
  methods: {
    cloking: function () {
      axios.post('http://localhost:4000/api/clocks/' + this.userid, {
        time: new Date,
        status: (!this.status),
      })
        .then(response => {
          this.endDateTime = Date.now();
          this.getClock();
        })
        .catch(error => {
          console.log(error);
        });
    },
    getClock: function () {
      axios.get("http://localhost:4000/api/clocks/" + this.userid, { header: 'Access-Control-Allow-Origin: *' })
        .then(response => {
          let data = response.data.data[0];
          if (data.length == 0) {
            this.time = '';
          } else {
            this.time = data.time;
            this.status = !this.status;
          }
          this.lastTime = response.data.data[response.data.data.length - 1].time;
        })
        .catch(error => {
          console.log(error);
        });
    }
  },
  data() {
    return {
      lastTime: '',
      status: false,
    };
  },
  mounted() {
    this.getClock();
  },
  beforeUnmount() {
  },
};

</script>

<template>
  <FancyCard>
    <template #header>Clock Manager</template>
    <template #mainpart>
      <div>
        <div>
          Last clock:
          <span class="important">{{
              this.lastTime == "" ? "none" : this.lastTime
          }}</span>
        </div>
        <div>
          clock is running :
          <span class="important">
            {{ this.status }}
          </span>
        </div>
        <div class="center">
          <FancyButton @click="cloking">{{ this.status ? "clock out" : "clock in" }}</FancyButton>
        </div>
      </div>
    </template>
  </FancyCard>
</template>

<style scoped>

</style>