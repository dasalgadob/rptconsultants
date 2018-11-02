//7# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

//console.log("valuations.js");
var descriptions = {}

$(function(){
  console.log("Test other ready");
  //Valuations Logic
  $('#valuation_position_type_id').change(function(){
    console.log("change: " );
    if($(this) != null && $(this).val() != ""){// make changes on the other selects
      console.log("Val:" + $(this).val() + "End val.");
      changeCriteriaValues($(this).val(), 1, 'valuation_knowledge_id');
      changeCriteriaValues($(this).val(), 2, 'valuation_skill_id');
      changeCriteriaValues($(this).val(), 3, 'valuation_definition_supervision_id');
      changeCriteriaValues($(this).val(), 4, 'valuation_risk_decision_id');
      changeCriteriaValues($(this).val(), 5, 'valuation_sustainability_id');
      changeCriteriaValues($(this).val(), 6, 'valuation_area_impact_id');
      changeCriteriaValues($(this).val(), 7, 'valuation_influence_id');

    }else{
      console.log("No cambios.");
    }

  }).change();
  //Cuando se cambia algunos de los criterios
  $('.valuation_criteria').change(function(){
    console.log("valuation_criteria: " );
    if($(this) != null && $(this).val() != ""){// make changes on the other selects
      console.log("Val:" + $(this).val()+ " "+ $(this).attr('id') + "End val."+ " " + $(this).attr('val'));
      $('#'+ $(this).attr('id') + "_text").text(descriptions[$(this).val()]);
    }else{
      console.log("No cambios.");
    }

  }).change();


});

function changeCriteriaValues(position_type_id, criteria_type_id, criteria_html_id){
  console.log("change knowledge:" + position_type_id);
  console.log("criteria_type_id:" + criteria_type_id);
  console.log("criteria_html_id:" + criteria_html_id);
  $('#'+ criteria_html_id).empty();
  $.get( "/criteria.json?criteria_type_id="+ criteria_type_id +"&position_type_id=" + position_type_id)
      .done(function( data ) {
        console.log("Data length:" + data['data'].length);
        for(var i=0; i<data['data'].length; i++){
          console.log(data['data'][i]);
          var id_criteria= data['data'][i]['attributes']['id'];
          var description = data['data'][i]['attributes']['description'];
          descriptions[id_criteria] = description;
          //get request for degree_id
          $('#'+ criteria_html_id).append($('<option>', {
            //descriptions[data['data'][i]['attributes']['id']]=
            value: id_criteria,
            text: data['data'][i]['attributes']['degree']['number']
          }));
          //solo cambiar la description para el primer item
          if(i==0){
            $('#'+criteria_html_id+ "_text" ).text(data['data'][i]['attributes']['description']);
          }
        }//end for
  });
}
