import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import Toaster from "@meforma/vue-toaster";
import { $vfm, VueFinalModal, ModalsContainer } from "vue-final-modal";

import "./assets/main.css";

const app = createApp(App);

app.use(router);
app.use(Toaster);
app.use(VueFinalModal.vfmPlugin);

app.component("VueFinalModal", VueFinalModal);

app.mount("#app");
