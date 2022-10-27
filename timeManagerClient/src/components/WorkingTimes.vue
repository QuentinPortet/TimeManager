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
            
        </template>
        </FancyCard>
</template>

<style scoped>

</style>