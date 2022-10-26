<script>
import axios from "axios";
export default {
    name: "ClockManager",
    methods: {
        cloking: function () {
            console.log("clocked");
            axios.post('http://localhost:4000/api/workingtimes', {
                startDateTime: this.startDateTime,
                endDateTime: Date.now(),
                user: this.user
            }, { headers: { 'Access-Control-Allow-Origin': '*' } })
                .then(response => {
                    this.endDateTime = Date.now()
                })
                .catch(error => {
                    console.log(error);
                });
        }
    },
    data() {
        return {
            userID: 1,
            startDateTime: '',
            endDateTime: 'error',
            end: '',
            user: ''
        };
    },
    mounted() {
        try {
            axios.get("http://localhost:4000/api/workingtimes/1" )
                .then(response => {
                    console.log(response.data.data);
                    this.startDateTime = response.data.data[0].end
                    this.endDateTime = response.data.data[0].end
                })
                .catch(error => {
                    console.log(error);
                });

        } catch (error) {
            console.log(error);
        }

    },
    beforeUnmount() {
    },
};

</script>


<template>
    <div class="card">
        <div class="fancy-stripe">.</div>
        <h1 class="header">
            ClockManager
        </h1>
        <div class="content">
            <div>
                First clock: <span class="important">{{ this.startDateTime }}</span>
            </div>
            <div>
                clock is running : <span class="important"> {{ this.endDateTime == '' ? 'yes' : 'no' }} </span>
            </div>
            <div class="center">
                <button @click="cloking">Clock</button>

            </div>
        </div>
    </div>
</template>

<style scoped>

</style>