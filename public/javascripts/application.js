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
  if (characters_remaining == -1) {
    var text = -characters_remaining + " character too many";
    var cls = "invalid";
  } else if (characters_remaining < -1) {
    var text = -characters_remaining + " characters too many";
    var cls = "invalid";
  } else if (characters_remaining == 1) {
    var text = characters_remaining + " character remaining"
    var cls = "valid";
  } else {
    var text = characters_remaining + " characters remaining"
    var cls = "valid";
  }
  var notice = $("#characters_remaining");
  notice.html(text);
  if (characters_remaining < 0) {
    notice.addClass("invalid");
    notice.removeClass("valid");
    $("#story_contribution_submit").attr("disabled", "disabled");
  } else {
    notice.addClass("valid");
    notice.removeClass("invalid");
    $("#story_contribution_submit").removeAttr("disabled");
  }
}

