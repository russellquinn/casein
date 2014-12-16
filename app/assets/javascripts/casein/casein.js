//= require jquery
//= require jquery_ujs
//= require bootstrap

jQuery(document).ready(function() {

	if (current_controller) {
		active_tab = $("#tab-" + current_controller);
		if (active_tab) {
			active_tab.addClass("active");
		}
	}

	if($("#notice")) {
		setTimeout(function() {
			$("#notice").fadeOut(1000);
		}, 10000);
	};

	$("#generate-random-password-checkbox").click(function() {
	  if ($(this).is(':checked')) {
	  	$("#casein_admin_user_password").attr("disabled", true);
	  	$("#casein_admin_user_password_confirmation").attr("disabled", true);
	  }
	  else {
	  	$("#casein_admin_user_password").removeAttr("disabled");
	  	$("#casein_admin_user_password_confirmation").removeAttr("disabled");
	  }
	});

});

toggleDiv = function(div) {
	switch ($("#"+div).css('display')) {
		case "none":
			$("#"+div).fadeIn(300);
		break;

		case "block":
			$("#"+div).fadeOut(300);
		break;
	}	
}
