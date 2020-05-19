$(document).on('turbolinks:load', function() {
  $(".input-text").on("keyup", function() {
    let countNum = $(this).val().length;
    $(".title-counter").text(countNum + "文字/50文字");
  });
});