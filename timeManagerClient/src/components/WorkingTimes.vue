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
export default {
    name: "ClockManager",

    methods: {
        getWorkingTimes: function (){
            axios.get("http://localhost:4000/api/workingtimes/"+this.userid, {params: {start: new Date(0), end: new Date(Date.now())}, header: 'Access-Control-Allow-Origin: *' })
            .then(response => {

                this.workingtimes = response.data.data;
                console.log(response.data.data);
                
            })
            .catch(error => {
                console.log(error);
            })
        }
    },
    mounted() {
        this.getWorkingTimes();
    },
    data() {
        return {
            workingtimes: [],
        };
    },
    beforeUnmount() {
    },
};

</script>

<template>
    <FancyCard>
        <template #header>Working Times</template>
        <template #mainpart>
            <li v-for="workingtime in workingtimes" :key="workingtime.id">
                {{workingtime.start}} - {{workingtime.end}}
            </li>
        </template>
        </FancyCard>
</template>

<style scoped>

</style>