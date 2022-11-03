<script setup>
defineProps({
  wtData: {
    type: Object,
    required: true,
  },
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
import moment from "moment";

export default {
  name: "WorkingTime",
  components: {
    FancyCard,
    FancyButton,
  },
  methods: {
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
          "http://localhost:4000/api/workingtimes/" + this.wtData.id,
          { start: start, end: end, user_id: this.userid },
          { header: "Access-Control-Allow-Origin: *" }
        )
        .then((response) => {
          this.showModal = false;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    deleteWorkingTime: function (event) {
      event.preventDefault();
      axios
        .delete("http://localhost:4000/api/workingtimes/" + this.wtData.id, {
          header: "Access-Control-Allow-Origin: *",
        })
        .then((response) => {
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
  <FancyCard :stripe="false">
    <template #header>
      <div style="text-align: center; padding-top: 16px; font-weight: 700">
        {{ moment(wtData.start).format("MMM Do YYYY, hh:mm") }} -
        {{ moment(wtData.end).format("MMM Do YYYY, hh:mm") }}
      </div></template
    >
    <template #mainpart>
      <div
        style="
          display: flex;
          justify-content: space-around;
          width: 50%;
          padding-left: 25%;
        "
      >
        <FancyButton @click="show(workingtime)"> Edit </FancyButton>
        <FancyButton color="red" @click="this.showDeleteModal(workingtime)">
          Delete
        </FancyButton>
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
      <template #header> Are you sure you want to delete this? </template>
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
  </vue-final-modal>
</template>

<style scoped></style>
