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
  name: "WorkingTime",

  methods: {
    getWorkingTimes: function (id) {
      id == undefined ? (id = this.userid) : (id = id); //ok
      axios
        .get("http://localhost:4000/api/workingtimes/" + id, {
          params: { start: new Date(0), end: new Date(Date.now()) },
          header: "Access-Control-Allow-Origin: *",
        })
        .then((response) => {
          this.workingtimes = response.data.data;
          console.log(response.data.data);
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
      console.log(wt.start);
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
      useridpicked == ""
        ? (useridpicked = this.userid)
        : (useridpicked = useridpicked);
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
  <FancyCard>
    <template #header>Working Time</template>
    <template #mainpart>
      <input
        type="number"
        v-model="workingtimeid"
        @change="this.getWorkingTimes($event.target.value)"
        id="useridpicker"
      />
      <span @click="this.getWorkingTimes()" style="cursor: pointer"
        >&#x21bb;</span
      >
      <FancyButton color="gray" @click="this.showCreate = true">+</FancyButton>
      <li v-for="workingtime in workingtimes" :key="workingtime.id">
        {{ workingtime.start }} - {{ workingtime.end }}
        <FancyButton @click="show(workingtime)"> Update </FancyButton>
        <FancyButton color="red" @click="this.showDeleteModal(workingtime)">
          Delete
        </FancyButton>
      </li>
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
            Update
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
