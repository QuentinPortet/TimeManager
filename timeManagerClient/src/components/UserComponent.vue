<script>
import axios from "axios";

export default {
  data() {
    return {
      username: "rien",
      email: "rien",
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
  <div class="card">
    <div class="fancy-stripe">-</div>
    <div class="header">
      {{ username }}
    </div>
    <div class="content">
      {{ email }}
    </div>
    <button @click="testitest"></button>
  </div>
</template>
