$(document).ready(function(){
  $('#refworksLink').attr('target', '_blank');
});

// Put cursor on main search box
$(document).ready(function(){
  setTimeout(function(){document.querySelector('#q.main-search-box').focus()}, 10);
});
