<script>
import axios from "axios";
import FancyButton from "./FancyButton.vue";

export default {
  components: {
    FancyButton,
  },
  data() {
    return {
      username: "",
      email: "toto@epitech.eu",
      userId: 0,
      info: null,
    };
  },
  mounted() {
    this.getUser();
  },
  methods: {
    createUser: function () {
      axios
        .post("http://localhost:4000/api/users", {
          username: "Titi",
          email: "titi@epitech.eu",
        })
        .then((response) => (this.info = response));
      this.$toast.show(`Utilisateur créé`);
    },
    updateUser: function () {
      axios
        .put("http://localhost:4000/api/users/1", {
          username: "Tutu",
          email: "tutu@modified.eu",
        })
        .then((response) => (this.info = response));
      this.$toast.show(`Profil modifié`);
    },
    getUser: function () {
      axios.get("http://localhost:4000/api/users/3").then((response) => {
        this.username = response.data.data.username;
        this.email = response.data.data.email;
        this.userId = response.data.data.id;
      });
    },
    deleteUser: function () {
      console.log(this.userId);
      axios
        .delete("http://localhost:4000/api/users/" + this.userId)
        .then((response) => (this.info = response));
      this.$toast.show(`Profil supprimé`);
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
  <div style="display: flex; justify-content: space-around; margin: 16px">
    <FancyButton @click="updateUser"> Modifier mon profil </FancyButton>
    <FancyButton
      @click="deleteUser"
      color="linear-gradient(323deg, rgba(107,0,0,1) 0%, rgba(154,17,0,1) 100%);"
    >
      Supprimer mon profil
    </FancyButton>
  </div>
  <div style="display: flex; justify-content: space-around; margin: 16px">
    <FancyButton
      @click="createUser"
      color="linear-gradient(323deg, rgba(0,170,119,1) 0%, rgba(0,156,154,1) 100%);"
    >
      Ajouter un nouvel utilisateur
    </FancyButton>
  </div>
</template>
