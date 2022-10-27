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
        
    },
    data() {
        return {
            
        };
    },
    mounted() {
        

    },
    beforeUnmount() {
    },
};

</script>


<template>
    <FancyCard>
        <template #header>Working Times</template>
        <template #mainpart>
            <div>
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
        </template>
        </FancyCard>
</template>

<style scoped>

</style>