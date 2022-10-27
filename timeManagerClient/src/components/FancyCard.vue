<script></script>

<template>
  <div class="card">
    <div class="fancy-stripe">-</div>
    <div class="header">
      <slot name="header">Oops, something happened</slot>
    </div>
    <div class="content">
      <slot name="mainpart">Oops, something happened</slot>
    </div>
  </div>
</template>

<style>
.card {
  margin: 7%;
  background: var(--color-background-soft);
  border-radius: 8px;
  box-shadow: 4px 4px 6px #11111166;
  padding-bottom: 16px;
  min-width: 300px;
  max-width: 45vw;
  margin: 0px 0px 16px 0px;
}

.card .fancy-stripe {
  border-top-left-radius: 8px;
  border-top-right-radius: 8px;
  background: linear-gradient(
    323deg,
    rgb(217, 255, 0) 0%,
    rgba(13, 255, 134, 1) 100%
  );
  width: 100%;
}

.card .header {
  margin: 16px;
  font-weight: 900;
  font-size: 20px;
}

.card .content {
  margin: 16px;
}

.card button {
  margin-top: 5%;
  padding: 10px;
  background-color: #2c3e50;
  border-radius: 5px;
  border-color: transparent;
}

.card .content .center {
  text-align: center;
}

.card .important {
  font-weight: 900;
  color: green;
}
</style>
