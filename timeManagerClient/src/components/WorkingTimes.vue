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
    name: "Working Times",

    methods: {
        getworkingTimes: function (){
            axios.get("http://localhost:4000/api/workingtimes/"+this.userid, {params: {start: new Date(0), end: new Date(Date.now())}, header: 'Access-Control-Allow-Origin: *' })
            .then(response => {

                this.workingTimes = response.data.data;
                
            })
            .catch(error => {
                console.log(error);
            })
        }
    },
    mounted() {
        this.getworkingTimes();
    },
    data() {
        return {
            workingTimes: [],
        };
    },
    beforeUnmount() {
    },
};

</script>

<template>
    <FancyCard  v-if='this.userid != ""'>
        <template #header>Working Times</template>
        <template #mainpart>
            <li v-for="workingtime in workingTimes" :key="workingtime.id" class="wt">
                {{workingtime.start}} - {{workingtime.end}}
            </li>
        </template>
        </FancyCard>
</template>

<style scoped>

</style>