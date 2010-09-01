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
  var characters_remaining = 140 - $("#story_contribution_text")[0].value.length;
  if (characters_remaining == 1) {
    var text = characters_remaining + " character remaining"
  } else {
    var text = characters_remaining + " characters remaining"
  }
  $("#characters_remaining").html(text);
}

