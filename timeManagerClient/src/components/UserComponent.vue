<script>
import axios from "axios";
import FancyCard from "./FancyCard.vue";

export default {
  components: {
    FancyCard,
  },
  data() {
    return {
      username: "Toto",
      email: "toto@epitech.eu",
      info: null,
    };
  },
  async mounted() {
    this.info = await axios
      .get("http://localhost:4000/api/users/1")
      .then((response) => (this.info = response));
  },
  methods: {
    testitest() {
      console.log(this.info);
    },
    createUser: function () {
      axios
        .post("http://localhost:4000/api/users", {
          headers: { "Access-Control-Allow-Origin": "*" },
        })
        .then((response) => (this.info = response));
    },
    updateUser: function () {
      axios
        .put("http://localhost:4000/api/users/1", {
          headers: { "Access-Control-Allow-Origin": "*" },
        })
        .then((response) => (this.info = response));
    },
    getUser: function () {
      axios
        .get("http://localhost:4000/api/users/1", {
          headers: { "Access-Control-Allow-Origin": "*" },
        })
        .then((response) => (this.info = response));
    },
    deleteUser: function () {
      axios
        .delete("http://localhost:4000/api/users/1", {
          headers: { "Access-Control-Allow-Origin": "*" },
        })
        .then((response) => (this.info = response));
    },
  },
};
</script>

<template>
  <FancyCard>
    <template #header> Users panel </template>
    <template #mainpart>
      <div class="content">
        You are currently logged in as <strong>{{ username }} </strong>.
        <br />
        Your registered email address is <strong>{{ email }} </strong>.
      </div>
    </template>
  </FancyCard>
  <!-- <div class="card">
    <div class="fancy-stripe">-</div>
    <div class="header">Users panel</div>
    <div class="content">
      You are currently logged in as <strong>{{ username }} </strong>.
      <br />
      Your registered email address is <strong>{{ email }} </strong>.
    </div>
    <button @click="testitest"></button>
  </div> -->
</template>
