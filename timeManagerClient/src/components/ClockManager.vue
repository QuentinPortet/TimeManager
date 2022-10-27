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
    name: "ClockManager",
    components: {
        FancyCard,
        FancyButton,
    },
    methods: {
        cloking: function () {
            axios.post('http://localhost:4000/api/clocks/' + this.userid, {
                time: Date.now(),
                status: false,
            })
                .then(response => {
                    this.endDateTime = Date.now();
                })
                .catch(error => {
                    console.log(error);
                });
        }
    },
    data() {
        return {
            time: '',
            status: false,
        };
    },
    mounted() {
        axios.get("http://localhost:4000/api/clocks/" + this.userid, { header: 'Access-Control-Allow-Origin: *' })
            .then(response => {
                let data = response.data.data[0];
                if (data.length == 0) {
                    this.time = '';
                } else {
                    this.time = data.time;
                }
                this.startDateTime = response.data.data[response.data.data.length - 1].start;
                this.endDateTime = response.data.data[0].end;
            })
            .catch(error => {
                console.log(error);
            });
    },
    beforeUnmount() {
    },
};

</script>

<template>
    <FancyCard>
        <template #header>Clock Manager</template>
        <template #mainpart>
            <div>
                <div>
                    First clock: <span class="important">{{ this.time }}</span>
                </div>
                <div>
                    Clock is running : <span class="important"> {{ this.status ? 'yes' : 'no' }} </span>
                </div>
                <div class="center">
                    <FancyButton @click="cloking"> <template #text>Clock</template></FancyButton>
                </div>
            </div>
        </template>
    </FancyCard>
</template>

<style scoped>

</style>