// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .

function open_window(_url, _width, _height) 
{
  var openTarget = "_contents";
  var nWidth= _width;
  var nHeight = _height;
  var sw = screen.availWidth;
  var sh = screen.availHeight;
  var px = 50 ;
  var py = 50;
  var openOption = "width = " + nWidth + ", height = " + nHeight + ", toolbar = no, top = " + py + ", left = " + px;

  var openURL = _url;
  w = window.open(openURL, openTarget, openOption);
  w.focus();
}