<script>
import axios from "axios";
import FancyCard from "./FancyCard.vue";
import FancyButton from "./FancyButton.vue";

export default {
  components: {
    FancyCard,
    FancyButton,
  },
  data() {
    return {
      username: "",
      email: "toto@epitech.eu",
    };
  },
  mounted() {
    axios.get("http://localhost:4000/api/users/1").then((response) => {
      this.username = response.data.data.username;
      this.email = response.data.data.email;
    });
  },
  methods: {
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
  <div class="title">Users panel</div>
  <div class="content" style="margin: 16px">
    You are currently logged in as <strong>{{ username }} </strong>.
    <br />
    Your registered email address is <strong>{{ email }} </strong>.
  </div>
  <div style="display: flex; justify-content: space-between; margin: 16px">
    <FancyButton>
      <template #text> Modifier mon profil </template>
    </FancyButton>
    <FancyButton
      color="linear-gradient(323deg, rgba(107,0,0,1) 0%, rgba(154,17,0,1) 100%);"
    >
      <template #text> Supprimer mon profil </template>
    </FancyButton>
  </div>
</template>
