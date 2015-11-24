// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require sweet-alert
//= require_tree .

function remove_fields (link) {
    $(link).previous("input[type=hidden]").value = "1";
    $(link).up(".fields").hide();
}

function add_fields(link, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    $(link).parent().before(content.replace(regexp, new_id));
    var texto = "Algumas bases possuem quantidade máxima de termos para execução das buscas.";
    swal("Atenção!", texto, "warning");
}

$(document).on("click", "a.link_to_add_fields", function(e){
            e.preventDefault();
            var link = $(this);
            var association = $(this).data("association");
            var content = $(this).data("content");
            add_fields(link, association, content);
});