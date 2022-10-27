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
      axios
        .post(
          "http://localhost:4000/api/workingtimes/" + this.userid,
          {
            startDateTime: this.startDateTime,
            endDateTime: Date.now(),
            user: this.user,
          },
          { header: "Access-Control-Allow-Origin: *" }
        )
        .then((response) => {
          this.endDateTime = Date.now();
        })
        .catch((error) => {
          console.log(error);
        });
    },
  },
  data() {
    return {
      userID: 1,
      startDateTime: "",
      endDateTime: "error",
      end: "",
      user: "",
    };
  },
  mounted() {
    axios
      .get("http://localhost:4000/api/workingtimes/" + this.userid)
      .then((response) => {
        console.log(response);
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
          <FancyButton @click="cloking">Clock</FancyButton>
        </div>
      </div>
    </template>
  </FancyCard>
</template>

<style scoped></style>
