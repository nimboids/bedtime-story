$(document).ready(function(){
  scrollToEndOfStory();
  $("#story_contribution_text").keyup(updateCharactersRemaining);
  $("#story_contribution_text").focus();
});

function scrollToEndOfStory() {
  var storyDiv = $("#story");
  if (storyDiv != null) {
    storyDiv.scrollTop(storyDiv[0].scrollHeight);
  }
}

function updateCharactersRemaining(){
  $("#characters_remaining").html((140 - $("#story_contribution_text")[0].value.length) +
      " characters remaining");
}

