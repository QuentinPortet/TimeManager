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
    clocking: function () {
      axios
        .post("http://localhost:4000/api/clocks/" + this.userid, {
          time: new Date(),
          status: true,
        })
        .then((response) => {
          this.endDateTime = Date.now();
          this.$toast.show(`Clocking registered`);
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
  data() {
    return {
      time: "",
      status: false,
    };
  },
  mounted() {
    axios
      .get("http://localhost:4000/api/clocks/" + this.userid, {
        header: "Access-Control-Allow-Origin: *",
      })
      .then((response) => {
        let data = response.data.data[0];
        if (data.length == 0) {
          this.time = "";
        } else {
          this.time = data.time;
        }
        this.startDateTime =
          response.data.data[response.data.data.length - 1].start;
        this.endDateTime = response.data.data[0].end;
      })
      .catch((error) => {
        console.log(error);
      });
  },
  beforeUnmount() {},
};
</script>

<template>
  <FancyCard>
    <template #header>Clock Manager</template>
    <template #mainpart>
      <div>
        <div>
          First clock:
          <span class="important">{{
            this.startDateTime == "" ? "none" : this.startDateTime
          }}</span>
        </div>
        <div>
          clock is running :
          <span class="important">
            {{ this.endDateTime == "" ? "yes" : "no" }}
          </span>
        </div>
        <div class="center">
          <FancyButton @click="clocking">Clock</FancyButton>
        </div>
      </div>
    </template>
  </FancyCard>
</template>

<style scoped></style>
