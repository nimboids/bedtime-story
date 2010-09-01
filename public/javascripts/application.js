$(document).ready(function(){
  var storyDiv = $("#story");
  if (storyDiv != null) {
    storyDiv.scrollTop(storyDiv[0].scrollHeight);
  }
  $("#story_contribution_text").keyup(update_characters_remaining);
  $("#story_contribution_text").focus();
});

function update_characters_remaining(){
  $("#characters_remaining").html((140 - $("#story_contribution_text")[0].value.length) +
      " characters remaining");
}

