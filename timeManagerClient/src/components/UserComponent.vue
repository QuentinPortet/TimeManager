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
      info: null,
    };
  },
  async mounted() {
    this.info = await axios
      .get("http://localhost:4000/api/users/1")
      .then((response) => {
        return response;
      });
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
      <div style="display: flex">
        <FancyButton @click="testitest" style="margin-right: 16px">
          <template #text> Ajouter un utilisateur </template>
        </FancyButton>
        <FancyButton
          color="linear-gradient(323deg, rgba(107,0,0,1) 0%, rgba(154,17,0,1) 100%);"
        >
          <template #text> Supprimer un utilisateur </template>
        </FancyButton>
      </div>
    </template>
  </FancyCard>
</template>