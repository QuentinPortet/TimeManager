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
import FancyButton from "./FancyButton.vue";
import FancyCard from "./FancyCard.vue";

export default {
  components: {
    FancyButton,
    FancyCard,
  },
  data() {
    return {
      username: "",
      email: "",
      userId: 0,
      userList: [],
      info: null,
    };
  },
  mounted() {
    this.getUser();
    this.getAllUsers();
    this.userList.reverse();
  },
  methods: {
    generateFakeWorkingTime() {
      const days = Math.floor(Math.random() * 99);
      const hours = Math.floor(Math.random() * 23);

      return days.toString() + "d, " + hours.toString() + "h";
    },
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
        .put("http://localhost:4000/api/users/1 ", {
          username: "Tutu",
          email: "tutu@modified.eu",
        })
        .then((response) => (this.info = response));
      this.$toast.show(`Profil modifié`);
    },
    getUser: function () {
      axios.get("http://localhost:4000/api/users/"+this.userid).then((response) => {
        console.log(response.data.data);
        this.username = response.data.data.username;
        this.email = response.data.data.email;
        this.userId = response.data.data.id;
      });
    },
    getAllUsers: function () {
      axios.get("http://localhost:4000/api/users").then((response) => {
        this.userList = response.data.data;
        console.log("list", this.userList);
      });
    },
    deleteUser: function () {
      axios
        .delete("http://localhost:4000/api/users/" + "4")
        .then((response) => (this.info = response));
      this.$toast.show(`Profil supprimé`);
    },
  },
};
</script>

<template>
  <div class="title">Users panel</div>
  <div class="content" style="margin: 16px">
    You are currently logged in as <strong>{{ this.username }} </strong>.
    <br />
    Your registered email address is <strong>{{ this.email }} </strong>.
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
  <div
    class="hidden-scrollbar"
    style="padding: 16px; max-height: 36vh; overflow: scroll"
  >
    <div v-for="user of userList" v-bind:key="user.id">
      <FancyCard stripe="false">
        <template #header>{{ user.username }}</template>
        <template #mainpart>
          <div style="display: flex">
            <div style="width: 45%">
              {{ user.email }}
            </div>
            <div>Total worktime: {{ generateFakeWorkingTime() }}</div>
          </div>
        </template>
      </FancyCard>
    </div>
  </div>
</template>

<style>
.hidden-scrollbar::-webkit-scrollbar {
  display: none;
}

.hidden-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
</style>
