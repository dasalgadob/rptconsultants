//7# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://coffeescript.org/

//console.log("valuations.js");
var descriptions = {}
var totalScore=0;
var currentValuation = {};
var degree = {};

$(function(){

  //On Ready se cargan los datos de degrees
  loadDegreesValues();



  //console.log("Test other ready");
  //Valuations Logic
  /*Desde aqui se actualizan todos los criterios cuando se
  elige tipo de posicion en el formulario.
  Este hace que se actualizen la descripcion de cada criterio y el score automaticall
  al igual que el Degree */
  $('#valuation_position_type_id').change(function(){
    //console.log("change: " );
    //Si se ha elegido algun valor se cambian todas las descripciones
    if($(this) != null && $(this).val() != ""){// make changes on the other selects
      totalScore=0;
      //console.log("Val:" + $(this).val() + "End val.");
      changeCriteriaValues($(this).val(), 1, 'valuation_knowledge_id');
      changeCriteriaValues($(this).val(), 2, 'valuation_skill_id');
      changeCriteriaValues($(this).val(), 3, 'valuation_definition_supervision_id');
      changeCriteriaValues($(this).val(), 4, 'valuation_risk_decision_id');
      changeCriteriaValues($(this).val(), 5, 'valuation_sustainability_id');
      changeCriteriaValues($(this).val(), 6, 'valuation_area_impact_id');
      changeCriteriaValues($(this).val(), 7, 'valuation_influence_id');
      //Score field is updated with the sum of the criterias


    }else{
      console.log("No cambios.");
    }
  }).change();


  //Event when score is changed to calculate the degree
  $('#valuation_score').change(function(){
    console.log("Scored changed");

    //alert($('#valuation_score').val());
  }).change();

  //Cuando se cambia algunos de los criterios
  $('.valuation_criteria').change(function(){
    //console.log("valuation_criteria: " );
    if($(this) != null && $(this).val() != ""){// make changes on the other selects
      //console.log("Val:" + $(this).val()+ " "+ $(this).attr('id') + "End val."+ " " + $(this).attr('val'));
       $('#'+ $(this).attr('id') + "_text").text(descriptions[$(this).val()]['description']);
      //cambiar score total con el nuevo elegido
      //console.log("Score to increase: " +descriptions[$(this).val()]['score'] );
      //obtener score para el valor actual
      var criteriaType = descriptions[$(this).val()]['criteria_type_id'];
      //console.log("criteriaType:" + criteriaType);
      var scoreActual = currentValuation[criteriaType];
      //console.log("scoreActual:" + scoreActual);
      //disminuir
      totalScore-= scoreActual;
      //console.log("totalScore:" + scoreActual);
      //actualizar y sumar nuevo valor
      currentValuation[criteriaType]=descriptions[$(this).val()]['score'];
      //console.log("currentValuation[criteriaType]:" + descriptions[$(this).val()]['score']);
      totalScore+=currentValuation[criteriaType];
      //console.log("totalScore:" + totalScore);
      $('#valuation_score').val(totalScore).trigger('change');
    }else{
      console.log("No cambios.");
    }

  }).change();


});

function changeCriteriaValues(position_type_id, criteria_type_id, criteria_html_id){
  //console.log("change knowledge:" + position_type_id);
  //console.log("criteria_type_id:" + criteria_type_id);
  //console.log("criteria_html_id:" + criteria_html_id);
  //Options values are deleted because new ones are going to replace them
  $('#'+ criteria_html_id).empty();
  //Get Request to the criterias for that position and type of criteria.
  $.get( "/criteria.json?criteria_type_id="+ criteria_type_id +"&position_type_id=" + position_type_id)
      .done(function( data ) {
        //console.log("Data length:" + data['data'].length);
        //Iterate through the result bringed.
        for(var i=0; i<data['data'].length; i++){
          //console.log(data['data'][i]);
          var id_criteria= data['data'][i]['attributes']['id'];
          var description = data['data'][i]['attributes']['description'];
          var score = data['data'][i]['attributes']['score'];
          var criteria_type_id = data['data'][i]['attributes']['criteria_type_id'];
          descriptions[id_criteria] ={};
          descriptions[id_criteria]['score']= score;
          descriptions[id_criteria]['description']= description;
          descriptions[id_criteria]['criteria_type_id']= criteria_type_id;
          //Solo el primer criterio debe aumentar el score
          if(i==0){
            totalScore+= descriptions[id_criteria]['score'];
            $('#valuation_score').val(totalScore).trigger('change');
            //console.log("Total parcial:"+ totalScore);
            currentValuation[criteria_type_id]= descriptions[id_criteria]['score'];
          }

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
  });//End GET Request
}//End changeCriteriaValues

function loadDegreesValues(){
  $.get( "/degrees.json")
      .done(function( data ) {
        console.log("loading Degrees values...");
        for(var i=0; i<data['data'].length; i++){
          degree[i] = data['data'][i]['attributes'];
          //console.log(data['data'][i]);
        }
      });//End done
}//End loadDegreesValues()
