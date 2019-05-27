// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/
$(function(){

    var myInput = document.getElementById("user_password");
    var letter = document.getElementById("letter");
    var capital = document.getElementById("capital");
    var number = document.getElementById("number");
    var special = document.getElementById("special");
    var length = document.getElementById("length");
    var confirmationPassword = document.getElementById("user_password_confirmation");
    var match = document.getElementById("match");

    // When the user clicks on the password field, show the message box
    myInput.onfocus = function() {
        console.log("Block");
        document.getElementById("message").style.display = "block";
    }

    // When the user clicks outside of the password field, hide the message box
    myInput.onblur = function() {
        //document.getElementById("message").style.display = "none";
    }

    confirmationPassword.onfocus = function(){
        document.getElementById("messageConfirmation").style.display = "block";
    }

    //confirmationPassword.onblur = function() {
    //    document.getElementById("messageConfirmation").style.display = "none";
    //}

    // When the user starts to type something inside the password field
    myInput.onkeyup = function() {
        disabledSubmitIfNotValid();
        // Validate lowercase letters
        var lowerCaseLetters = /[a-z]/g;

        if(myInput.value.match(lowerCaseLetters)) {
            changeClassTo(letter, 'valid');
        } else {
            changeClassTo(letter, 'invalid');
        }

        // Validate capital letters
        var upperCaseLetters = /[A-Z]/g;
        if(myInput.value.match(upperCaseLetters)) {
            changeClassTo(capital, 'valid');
        } else {
            changeClassTo(capital, 'invalid');
        }

        // Validate numbers
        var numbers = /[0-9]/g;
        if(myInput.value.match(numbers)) {
            changeClassTo(number, 'valid');
        } else {
            changeClassTo(number, 'invalid');
        }

        //Validates special character
        var format = /[ ´¨~^`¿¡!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
        if(myInput.value.match(format)){
            changeClassTo(special, 'valid');
        } else {
            changeClassTo(special, 'invalid');
        }

        // Validate length
        if(myInput.value.length >= 8) {
            changeClassTo(length, 'valid');
        } else {
            changeClassTo(length, 'invalid');
        }

        if(myInput.value.match(lowerCaseLetters) && myInput.value.match(upperCaseLetters)
        && myInput.value.match(numbers) && myInput.value.match(format) && myInput.value.length >= 8){
            changeClassTo(myInput, 'valid-input');
        }else{
            changeClassTo(myInput, 'invalid-input');
        }
    }//End of myInput on keyup

    confirmationPassword.onkeyup = function(){
        console.log(myInput.value + " " + confirmationPassword.value);
        disabledSubmitIfNotValid();
        if(confirmationPassword.value === myInput.value){
            console.log("equal");
            $('#match').text('Los passwords coinciden.');
            $('#user_password_confirmation').removeClass('invalid-input');
            $('#user_password_confirmation').addClass('valid-input');
            match.classList.remove("invalid");
            match.classList.add("valid");
        }else{
            console.log("not equal");
            $('#user_password_confirmation').removeClass('valid-input');
            $('#user_password_confirmation').addClass('invalid-input');
            $('#match').text('Los passwords no coinciden.');
            match.classList.remove("valid");
            match.classList.add("invalid");
        }
    }

});


//Function to add invalid and removed invalid, or the other case add valid and remove invalid
function changeClassTo( element, clase){
    if(clase === 'invalid'){
        $(element).removeClass('valid');
        $(element).addClass('invalid');
    }else if(clase === 'valid'){
        $(element).removeClass('invalid');
        $(element).addClass('valid');
    }else if(clase === 'valid-input'){
        $(element).removeClass('invalid-input');
        $(element).addClass('valid-input');
    }else if(clase === 'invalid-input'){
        $(element).removeClass('valid-input');
        $(element).addClass('invalid-input');
    }
}

function validPassword(password){
    var lowerCaseLetters = /[a-z]/g;
    var upperCaseLetters = /[A-Z]/g;
    var numbers = /[0-9]/g;
    var format = /[ ´¨~^`¿¡!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/;
    var myInput = document.getElementById("user_password");
    if(myInput.value.match(lowerCaseLetters) && myInput.value.match(upperCaseLetters)
        && myInput.value.match(numbers) && myInput.value.match(format) && myInput.value.length >= 8){
        return true;
    }
    return false;
}

function disabledSubmitIfNotValid(){
    console.log("disable if");
    if($('#user_password').val() == '' && $('#user_password_confirmation').val() == ''){
        $('#submit').removeAttr('disabled');
    }
    else if($('#user_password').val() != '' && validPassword($('#user_password').val() )
        && $('#user_password').val() === $('#user_password_confirmation').val()){
        $('#submit').removeAttr('disabled');
    }else{
        $('#submit').attr('disabled','disabled');
    }
}