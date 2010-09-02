$(document).ready(function() {
  scrollToEndOfStory();
  setupContributionForm();
  setAddThisTitle();
  setTimeout(updateCountdown, 1000);
});

function scrollToEndOfStory() {
  var storyDiv = $("#story");
  if (storyDiv.length != 0) {
    storyDiv.scrollTop(storyDiv[0].scrollHeight);
  }
}

function setupContributionForm() {
  var textarea = $("#story_contribution_text");
  if (textarea.length != 0) {
    textarea.keyup(updateCharactersRemaining);
    textarea.focus();
  }
}

function setAddThisTitle() {
  $("#add_this a").attr("addthis:title", "I've helped write the Byte Night bedtime story");
}

function updateCharactersRemaining() {
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

function updateCountdown() {
  var seconds = $("#countdown_seconds").html() - 1;
  if (seconds < 0) {
    seconds = 59;
    var minutes = $("#countdown_minutes").html() - 1;
    if (minutes < 0) {
      minutes = 59;
      var hours = $("#countdown_hours").html() - 1;
      if (hours < 0) {
        hours = 23;
        var days = $("#countdown_days").html() - 1;
        if (days < 0) {
          days = 0;
        }
        $("#countdown_days").html(days);
      }
      $("#countdown_hours").html(hours);
    }
    $("#countdown_minutes").html(minutes);
  }
  $("#countdown_seconds").html(seconds);
  setTimeout(updateCountdown, 1000);
}
