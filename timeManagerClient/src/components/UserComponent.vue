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
  mounted() {
    axios
      .get("http://localhost:4000/api/users/1", {
        headers: { "Access-Control-Allow-Origin": "*" },
      })
      .then((response) => (this.info = response));
    console.log("reponse: ", this.info);
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
  </div>
</template>
