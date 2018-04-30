function submitForm() {
  console.log('submit');
  $.ajax({
    url: "/",
    method: "POST",
    data: { string: $('#string').val(), pattern: $('#pattern').val() }
  }).done(function(data) {
    displayData(data);
  });
}

function displayData(data) {
  var results = JSON.parse(data)['results'];
  var output = JSON.parse(data)['string'];
  for(var i = 0; i < results.length; i++) {
    output = output.replace(results[i], '<span class="highlight">' + results[i] + '</span>')
  }

  $('#results').html(output)
}

$(document).ready(function() {
  $('#pattern').on('change keyup paste', submitForm);
  $('#string').on('change keyup paste', submitForm);
});
