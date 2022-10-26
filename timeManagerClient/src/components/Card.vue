<script></script>

<template>
  <div class="card">
    <div class="fancy-stripe">-</div>
    <div class="header">
      <slot name="header"></slot>
    </div>
    <div class="content" name="mainpart">
      <slot></slot>
    </div>
  </div>
</template>
