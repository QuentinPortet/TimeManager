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
