# times = [[3,5,7], [2,3,8], [3,5,7], [2,3,8],[3,5,7]]
# @sc = new Scheduler(5, 3, times, 0)
# @method = new Method(@sc)
# F = @method.start(0.1, 10)
# console.log F

$  ->
  console.log('loaded');
  $('td').click ->
    console.log('clicked', @)
    input = $('input', @)
    div = $('div', @)
    text = div.toggleClass('hidden').text()
    input.toggleClass('hidden').focus().val(text)
    input.blur ->
      console.log('blured')
