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
      showCreate: false,
      showDelete: false,
      showEdit: false,
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
    createUser: function (event) {
      event.preventDefault();
      let username = document.getElementById("newUsername").value;
      let email = document.getElementById("newEmail").value;
      axios
        .post("http://localhost:4000/api/users", {
          username: username,
          email: email,
        })
        .then((response) => (this.info = response));
      this.$toast.show(`Utilisateur créé`);
      this.showCreate = false;
    },
    updateUser: function (event) {
      event.preventDefault();
      let username = document.getElementById("editUsername").value;
      let email = document.getElementById("editEmail").value;
      axios
        .put("http://localhost:4000/api/users/1 ", {
          username: username,
          email: email,
        })
        .then((response) => (this.info = response));
      this.$toast.show(`Profil modifié`);
      this.showEdit = false;
      this.getUser();
    },
    getUser: function () {
      axios.get("http://localhost:4000/api/users/" + this.userid).then((response) => {
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
    deleteUser: function (event) {
      event.preventDefault();
      axios
        .delete("http://localhost:4000/api/users/" + this.userid)
        .then((response) => (this.info = response));
      this.$toast.show(`Profil supprimé`);
      this.showDelete = false;
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
    <FancyButton @click="this.showEdit = true"> Modifier mon profil </FancyButton>
    <FancyButton @click="this.showDelete = true"
      color="linear-gradient(323deg, rgba(107,0,0,1) 0%, rgba(154,17,0,1) 100%);">
      Supprimer mon profil
    </FancyButton>
  </div>
  <div style="display: flex; justify-content: space-around; margin: 16px">
    <FancyButton @click="showCreate = true"
      color="linear-gradient(323deg, rgba(0,170,119,1) 0%, rgba(0,156,154,1) 100%);">
      Ajouter un nouvel utilisateur
    </FancyButton>
  </div>
  <div class="hidden-scrollbar" style="padding: 16px; max-height: 36vh; overflow: scroll">
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
  <vue-final-modal v-model="showCreate" classes="modal-container" content-class="modal-content" style="z-index: 2;">
    <span>Create new User</span>
    <form>
      <label>Username: </label>
      <input id="newUsername" type="text"><br>
      <label>Email: </label>
      <input id="newEmail" type="email"><br>
      <FancyButton @click="createUser($event)">Create</FancyButton>
    </form>
  </vue-final-modal>

  <vue-final-modal v-model="showDelete" classes="modal-container" content-class="modal-content">
    <span>Delete your account ?</span>
    <form>
      <FancyButton color="green" @click="this.deleteUser($event)">Yes</FancyButton>
      <FancyButton color="red" @click="this.showDelete = false">No</FancyButton>
    </form>
  </vue-final-modal>

  <vue-final-modal v-model="showEdit" classes="modal-container" content-class="modal-content">
    <span>Edit your account informations</span>
    <form>
      <input id="editUsername" type="text" v-model="username"><br>
      <input id="editEmail" type="email" v-model="email"><br>
      <FancyButton color="green" @click="updateUser($event)">Update</FancyButton>
    </form>
  </vue-final-modal>

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
