// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
window.onload=function(){
  var storyDiv = document.getElementById("story");
  storyDiv.scrollTop = storyDiv.scrollHeight;
  var contributionTextarea = document.getElementById("story_contribution_text");
  contributionTextarea.focus();
}
