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
            id == undefined ? id = this.userid : id = id; //ok
            axios.get("http://localhost:4000/api/workingtimes/" + id, { params: { start: new Date(0), end: new Date(Date.now()) }, header: 'Access-Control-Allow-Origin: *' })
                .then(response => {
                    this.workingtimes = response.data.data;
                    console.log(response.data.data);
                })
                .catch(error => {
                    console.log(error);
                })
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
        submit: function () {
            let start = document.getElementById("start").value;
            let end = document.getElementById("end").value;
            axios.put("http://localhost:4000/api/workingtimes/" + this.workingtime.id, { start: start, end: end, user_id: this.userid }, { header: 'Access-Control-Allow-Origin: *' })
                .then(response => {
                    this.getWorkingTimes();
                    this.showModal = false;
                })
                .catch(error => {
                    console.log(error);
                })
        },
        delete: function () {
            axios.delete("http://localhost:4000/api/workingtimes/" + this.workingtime.id, { header: 'Access-Control-Allow-Origin: *' })
                .then(response => {
                    this.getWorkingTimes();
                    this.showDelete = false;
                })
                .catch(error => {
                    console.log(error);
                })
        },
        showDeleteModal: function (wt) {
            this.showDelete = true;
            console.log("ici")
            this.workingtime = wt;
        }
    },
    mounted() {
        this.getWorkingTimes();

    },
    data() {
        return {
            showModal: false,
            showDelete: false,
            workingtimeid: '',
            workingtime: '',
            workingtimes: [],
        };
    },
    beforeUnmount() {
    },
};

</script>

<template>
    <FancyCard>
        <template #header>Working Time</template>
        <template #mainpart>
            <input type="number" v-model="workingtimeid" @change="this.getWorkingTimes($event.target.value)" />
            <li v-for="workingtime in workingtimes" :key="workingtime.id">
                {{ workingtime.start }} - {{ workingtime.end }} <FancyButton @click="show(workingtime)"> Update
                </FancyButton>
                <FancyButton color="red" @click="this.showDeleteModal(workingtime)"> Delete </FancyButton>
            </li>
        </template>
    </FancyCard>


    <vue-final-modal v-model="showModal" classes="modal-container" content-class="modal-content">
        <span>Update it</span>
        <div>
            For working time id: {{ this.workingtime.id }}
        </div>
        <form id="updateForm">
            <input hidden name="id" type="text" v-model='this.workingtime.id'><br>
            <input id="start" name="start" type="datetime-local" v-model='this.workingtime.start'><br>
            <input id="end" name="end" type="datetime-local" v-model='this.workingtime.end'><br>
            <FancyButton color="green" @click="this.submit()"> Update </FancyButton>
        </form>
        <button class="modal-close" @click="this.showModal = false">
            x
        </button>
    </vue-final-modal>
    <vue-final-modal v-model="showDelete" classes="modal-container" content-class="modal-content">
        <span>Are you sure to delete ?</span><br>
        <FancyButton color="green" @click="this.delete()">yes</FancyButton>
        <FancyButton color="red" @click="this.showDelete = false">no</FancyButton>

    </vue-final-modal>

</template>

<style scoped>

</style>