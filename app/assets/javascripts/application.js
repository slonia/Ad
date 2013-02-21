// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery_nested_form
//= require_tree .
$(function() {
  var fieldsCount,
      maxFieldsCount = 4,
      $addLink = $('a.add_nested_fields');
  
  function toggleAddLink() {
    $addLink.toggle(fieldsCount <= maxFieldsCount)
  }

  $(document).on('nested:fieldAdded', function() {
    fieldsCount += 1;
    toggleAddLink();
  });

  $(document).on('nested:fieldRemoved', function() {
    fieldsCount -= 1;
    toggleAddLink();
  });  

  // count existing nested fields after page was loaded
  fieldsCount = $('form .fields').length;
  toggleAddLink();
})
function ch_sel()
{
   $('form').removeAttr("action").attr("action", "ads/"+$("#act option:selected").val());
}