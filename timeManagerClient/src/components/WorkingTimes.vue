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
import WorkingTime from "./WorkingTime.vue";
import FancyCard from "./FancyCard.vue";
import FancyButton from "./FancyButton.vue";

export default {
  name: "WorkingTimes",
  components: {
    WorkingTime,
    FancyCard,
    FancyButton,
  },
  methods: {
    getWorkingTimes: function (id) {
      if (id === undefined) {
        id = this.userid;
      }
      axios
        .get("http://localhost:4000/api/workingtimes/" + id, {
          params: { start: new Date(0), end: new Date(Date.now()) },
          header: "Access-Control-Allow-Origin: *",
        })
        .then((response) => {
          this.workingtimes = response.data.data;
          this.workingtimes = this.workingtimes.reverse();
          console.log("blop", this.workingtimes[0]);
        })
        .catch((error) => {
          console.log(error);
        });
    },
    show: function (wt) {
      this.showModal = true;
      wt.start = wt.start.replace("T", " ");
      wt.end = wt.end.replace("T", " ");
      wt.start = wt.start.replace("Z", "");
      wt.end = wt.end.replace("Z", "");
      this.workingtime = wt;
    },
    UpdateWorkingTime: function (event) {
      event.preventDefault();
      let start = document.getElementById("newStartUpdate").value;
      let end = document.getElementById("newEndUpdate").value;
      axios
        .put(
          "http://localhost:4000/api/workingtimes/" + this.workingtime.id,
          { start: start, end: end, user_id: this.userid },
          { header: "Access-Control-Allow-Origin: *" }
        )
        .then((response) => {
          this.getWorkingTimes();
          this.showModal = false;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    createWorkingTime: function (event) {
      event.preventDefault();
      let useridpicked = document.getElementById("useridpicker").value;
      if (useridpicked === "") {
        useridpicked = this.userid;
      }
      let start = document.getElementById("newStart").value;
      let end = document.getElementById("newEnd").value;
      console.log(start);
      axios
        .post(
          "http://localhost:4000/api/workingtimes/" + useridpicked,
          { start: start, end: end },
          { header: "Access-Control-Allow-Origin: *" }
        )
        .then((response) => {
          this.getWorkingTimes();
          this.showModal = false;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    deleteWorkingTime: function (event) {
      event.preventDefault();
      axios
        .delete(
          "http://localhost:4000/api/workingtimes/" + this.workingtime.id,
          { header: "Access-Control-Allow-Origin: *" }
        )
        .then((response) => {
          this.getWorkingTimes();
          this.showDelete = false;
        })
        .catch((error) => {
          console.log(error);
        });
      this.showDelete = false;
    },
    showDeleteModal: function (wt) {
      this.showDelete = true;
      this.workingtime = wt;
    },
  },
  mounted() {
    this.getWorkingTimes();
  },
  data() {
    return {
      showModal: false,
      showDelete: false,
      showCreate: false,
      workingtimeid: "",
      workingtime: "",
      workingtimes: [],
    };
  },
  beforeUnmount() {},
};
</script>

<template>
  <FancyCard style="width: 70%">
    <template #header>My working times</template>
    <template #mainpart>
      <div style="width: 25%; padding-left: 37%">
        <input
          style="border-radius: 8px; width: 100%"
          type="number"
          v-model="workingtimeid"
          @change="this.getWorkingTimes($event.target.value)"
          id="useridpicker"
        />
      </div>
      <div
        style="
          display: flex;
          justify-content: space-around;
          width: 50%;
          padding-left: 25%;
        "
      >
        <FancyButton @click="this.getWorkingTimes()" style="cursor: pointer"
          >Refresh</FancyButton
        >
        <FancyButton color="gray" @click="this.showCreate = true"
          >Add working time</FancyButton
        >
      </div>
      <div v-for="workingtime in workingtimes" :key="workingtime.id">
        <WorkingTime :wtData="workingtime" :userid="userid"></WorkingTime>
      </div>
    </template>
  </FancyCard>

  <vue-final-modal
    v-model="showModal"
    classes="modal-container"
    content-class="modal-content"
  >
    <FancyCard>
      <template #header>Update your working time</template>
      <template #mainpart>
        <div>For working time id: {{ workingtime.id }}</div>
        <form id="updateForm">
          <input hidden name="id" type="text" v-model="workingtime.id" /><br />
          <input
            id="newStartUpdate"
            name="start"
            type="datetime-local"
            v-model="workingtime.start"
          /><br />
          <input
            id="newEndUpdate"
            name="end"
            type="datetime-local"
            v-model="workingtime.end"
          /><br />
          <FancyButton color="green" @click="UpdateWorkingTime($event)">
            Edit
          </FancyButton>
        </form>
      </template>
    </FancyCard>
  </vue-final-modal>

  <vue-final-modal
    v-model="showDelete"
    classes="modal-container"
    content-class="modal-content"
  >
    <FancyCard>
      <template #header> Are you sure to delete ? </template>
      <template #mainpart>
        <div
          style="
            padding-left: 25%;
            display: flex;
            width: 50%;
            justify-content: space-around;
          "
        >
          <FancyButton color="danger" @click="this.deleteWorkingTime($event)"
            >Yes</FancyButton
          >
          <FancyButton @click="showDelete = false">No</FancyButton>
        </div>
      </template>
    </FancyCard>
  </vue-final-modal>

  <vue-final-modal
    v-model="showCreate"
    classes="modal-container"
    content-class="modal-content"
  >
    <FancyCard>
      <template #header> Create new Working time </template>
      <template #mainpart>
        <form>
          <label>Start: </label>
          <input id="newStart" type="datetime-local" /><br />
          <label>End: </label>
          <input id="newEnd" type="datetime-local" /><br />
          <FancyButton @click="createWorkingTime($event)">Create</FancyButton>
        </form>
      </template>
    </FancyCard>
  </vue-final-modal>
</template>

<style scoped></style>
