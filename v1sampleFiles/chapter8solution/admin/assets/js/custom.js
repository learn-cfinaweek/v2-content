$(document).ready(function(){
	$(".pop").popover({trigger:'hover'});
	$.each($( '.wysiwyg' ), function(i, v){
		var editor = CKEDITOR.replace( v );
	});
	$('.datepicker').datepicker();
	
});