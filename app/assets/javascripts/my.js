$(document).ready(function() {
  $("#custom_select").on('change', function(event){

    // country = $("#custom_select option:selected").val();
    country = $("#custom_select option:selected").html();
    // alert(country.toString());

    var params =
      "country=" + $('#custom_select option:selected').val() +
      "&tt=" + "test";

    $.ajax({
      type: "POST",
      url: "select_country",
      data: params,
      dataType: 'script',
      success: function(result){
        alert( "data: " + result );
      },
    });
  })

  $("#custom_select").chosen();
});


