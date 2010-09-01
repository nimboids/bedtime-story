$(document).ready(function(){
  var storyDiv = $("#story");
  if (storyDiv != null) {
    storyDiv.scrollTop(storyDiv[0].scrollHeight);
  }
  $("#story_contribution_text").focus();
});

