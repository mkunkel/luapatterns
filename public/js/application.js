function submitForm() {
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

  if (results.length == 0) {
    var output = '<em>No results found</em>';
  } else {
    for(var i = 0; i < results.length; i++) {
      var output = JSON.parse(data)['string'];
      output = output.replace(results[i], '<span class="highlight">' + results[i] + '</span>');
    }
  }

  $('#results').html(output)
}

function showExample() {
  $('#pattern').val('[1-3]?%d %u%l+ %d%d%d%d% %(%l%l%l%)');
  $('#string').val('The date was 19 September 1765 (est) as best as we can tell');
  submitForm();
}

$(document).ready(function() {
  $('#pattern').on('change keyup paste', submitForm);
  $('#string').on('change keyup paste', submitForm);
  $('#example').on('click', showExample);
  $('form').on('submit', function(e) { e.preventDefault(); });
});
