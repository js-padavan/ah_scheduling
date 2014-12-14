

model =
  rows: 5
  cols: 3
  init_values:  [[7, 5, 3, 3, 5, 7, 7, 5, 3, 3, 5, 7, 7, 5, 3],
                [8, 3, 2, 2, 3, 8, 8, 3, 2, 2, 3, 8, 8, 3, 2],
                [7, 5, 3, 3, 5, 7, 7, 5, 3, 3, 5, 7, 7, 5, 3],
                [8, 3, 2, 2, 3, 8, 8, 3, 2, 2, 3, 8, 8, 3, 2],
                [7, 5, 3, 3, 5, 7, 7, 5, 3, 3, 5, 7, 7, 5, 3],
                [9, 5, 5, 5, 5, 9, 9, 5, 5, 5, 5, 9, 9, 5, 5],
                [7, 8, 3, 3, 8, 7, 7, 8, 3, 3, 8, 7, 7, 8, 3],
                [9, 5, 5, 5, 5, 9, 9, 5, 5, 5, 5, 9, 9, 5, 5],
                [7, 8, 3, 3, 8, 7, 7, 8, 3, 3, 8, 7, 7, 8, 3],
                [9, 5, 5, 5, 5, 9, 9, 5, 5, 5, 5, 9, 9, 5, 5],
                [7, 5, 3, 3, 5, 7, 7, 5, 3, 3, 5, 7, 7, 5, 3],
                [8, 3, 2, 2, 3, 8, 8, 3, 2, 2, 3, 8, 8, 3, 2],
                [7, 5, 3, 3, 5, 7, 7, 5, 3, 3, 5, 7, 7, 5, 3],
                [8, 3, 2, 2, 3, 8, 8, 3, 2, 2, 3, 8, 8, 3, 2],
                [7, 5, 3, 3, 5, 7, 7, 5, 3, 3, 5, 7, 7, 5, 3],
                [9, 5, 5, 5, 5, 9, 9, 5, 5, 5, 5, 9, 9, 5, 5],
                [7, 8, 3, 3, 8, 7, 7, 8, 3, 3, 8, 7, 7, 8, 3],
                [9, 5, 5, 5, 5, 9, 9, 5, 5, 5, 5, 9, 9, 5, 5],
                [7, 8, 3, 3, 8, 7, 7, 8, 3, 3, 8, 7, 7, 8, 3],
                [9, 5, 5, 5, 5, 9, 9, 5, 5, 5, 5, 9, 9, 5, 5],
                [7, 5, 3, 3, 5, 7, 7, 5, 3, 3, 5, 7, 7, 5, 3],
                [8, 3, 2, 2, 3, 8, 8, 3, 2, 2, 3, 8, 8, 3, 2],
                [7, 5, 3, 3, 5, 7, 7, 5, 3, 3, 5, 7, 7, 5, 3],
                [8, 3, 2, 2, 3, 8, 8, 3, 2, 2, 3, 8, 8, 3, 2],
                [7, 5, 3, 3, 5, 7, 7, 5, 3, 3, 5, 7, 7, 5, 3],
                [9, 5, 5, 5, 5, 9, 9, 5, 5, 5, 5, 9, 9, 5, 5],
                [7, 8, 3, 3, 8, 7, 7, 8, 3, 3, 8, 7, 7, 8, 3],
                [9, 5, 5, 5, 5, 9, 9, 5, 5, 5, 5, 9, 9, 5, 5],
                [7, 8, 3, 3, 8, 7, 7, 8, 3, 3, 8, 7, 7, 8, 3],
                [9, 5, 5, 5, 5, 9, 9, 5, 5, 5, 5, 9, 9, 5, 5]]


generateMatrix = ->
  for i in [0...model.cols]
    addColumn()
  for i in [0...model.rows]
    addRow()

  elems = $('td input')
  for i in [0...model.rows]
    for j in [0...model.cols]
      elems[i*model.cols + j].value = model.init_values[i][j]
  return

addRow = ->
  tr = $('<tr></tr>')
  td = $('<td><input type="text" /></td>')
  for i in [0...model.cols]
    tr.append(td.clone())
  $('#prc_time').append(tr)

removeRow = ->
  $('tr:last-child').detach()

addColumn = ->
  td = $('<td><input type="text" /></td>')
  td.clone().insertAfter('td:last-child')

removeColumn = ->
  $('td:last-child').detach()


readPrcTime = ->
  elems = $('td input')
  prc_time = helpers.create2DArray(model.rows, model.cols)
  for i in [0...model.rows]
    for j in [0...model.cols]
      prc_time[i][j] =  parseInt(elems[i*model.cols + j].value)

  console.table prc_time
  return prc_time

printMatrix = (arr, str) ->
  rows = arr.length
  cols = arr[0].length
  table = $('<table></table>')
  tr = $('<tr></tr>')
  td = $('<td></td>')
  for i in [0...rows]
    row = tr.clone()
    for j in [0...cols]
      item = td.clone().text(arr[i][j])
      row.append item
    table.append row

  buf = $('<div></div>').append('<div>' + str + '</div>').append(table)
  $('<div class="panel"></div>').append(buf)

print_results = (res) ->
  $('#initial_F').text("initial F=" + res.initial_F)
  $('#global_F').text("global_F=" + res.global_F)
  $('.results>.panel').remove()
  $('.results').append printMatrix(res.global_schedule, 'полученное расписание')
  for l in [0...res.prc_start_time.length]
    $('.results').append printMatrix(res.prc_start_time[l], 'Матрица времени начала обработки на ' + l + ' приборе')
  console.log res.global_F

increment_counter = ->
  value = parseInt($('.counter-value').text());
  value++;
  $('.counter-value').text(value)

reset_counter = ->
  $('.counter-value').text('0')

getRandomColor = ->
    letters = '0123456789ABCDEF'.split('');
    color = '#';
    for i in [0...6]
        color += letters[Math.floor(Math.random() * 16)];
    return color;



build_diagrams = (prc_time, L, N, prc_start_time, schedule)->
  svg_container = $('#svg')
  # svg_container.empty()
  svg_height = svg_container.height()
  svg_width = svg_container.width()
  s = Snap('#svg')
  s.clear()
  console.log 'svg!:', s
  colors = new Array(N)
  for i in [0...N]
    colors[i] = getRandomColor()
  paddingX = 10
  paddingY = 10
  spaceY = 30   # space beetween lines
  # min_scale = 20

  #  calculation scale

  # scale = if scale > min_scale then scale else min_scale

  define_scale = ->
    min_time = Number.MAX_SAFE_INTEGER
    min_line_width = 40;
    for i in [0...N]
      for l in [0...L]
        if prc_time[i][l] < min_time
          min_time = prc_time[i][l]
    min_scale = min_line_width / min_time

    for i in [0...N]
      if (prc_start_time[L-1][N-1][i] > 0)
        c_max = prc_start_time[L-1][N-1][i] + prc_time[i][L-1]
    scale = (svg_width - paddingX*2)/c_max

    return if scale > min_scale then scale else min_scale


  calc_required_width = ->
    required_width = 0
    for i in [0...N]
      if (prc_start_time[L-1][N-1][i] > 0)
        required_width = (prc_start_time[L-1][N-1][i] + prc_time[i][L-1])*scale
    if svg_width < required_width then  svg_container.width(required_width + 10)


  calc_required_height = ->
    required_height = paddingY * 2 + spaceY * L + L;
    svg_container.height(required_height)


  scale = define_scale()
  calc_required_width()
  calc_required_height()

  cur_Y = 0
  for l in [0...L]
    cur_Y += spaceY
    for i in [0...N]
      req_type = schedule[l][i]
      start_X = prc_start_time[l][req_type][i] * scale
      end_X = (prc_start_time[l][req_type][i] + prc_time[i][l]) * scale
      s.paper.line(start_X, cur_Y, end_X, cur_Y)
      .attr({stroke: colors[req_type], strokeWidth: 4, cursor: 'pointer', 'data-reqtype': req_type})
      .hover(
        ->
          reqType = @.attr('data-reqtype')
          elems =  s.selectAll("[data-reqtype=\"#{reqType}\"]")
          for i in [0...elems.length]
            elems[i].addClass('line-hovered')
        ->
          reqType = @.attr('data-reqtype')
          elems =  s.selectAll("[data-reqtype=\"#{reqType}\"]")
          for i in [0...elems.length]
            elems[i].removeClass('line-hovered')
      )
      # drawing grid lines
      s.paper.line(start_X, 0, start_X, spaceY*L + 10)
      .attr({stroke: 'black', strokeWidth: 1, opacity: 0.7})
      s.paper.text(start_X + 1, 10, prc_start_time[l][req_type][i])
      .attr({'font-size': 10})

      s.paper.line(end_X, 0, end_X, spaceY * L + spaceY)
      .attr({stroke: 'black', strokeWidth: 1, opacity: 0.7})
      s.paper.text(end_X + 1, spaceY*L + spaceY - 3, prc_start_time[l][req_type][i] + prc_time[i][l] )
      .attr({'font-size': 10})

      pos_X = start_X + (end_X - start_X) / 2 - 5
      s.paper.text(pos_X, cur_Y - 5, '' + prc_time[i][l]).attr({'color': 'grey', 'font-size': 12})

  return

$  ->
  console.log 'svg!!'



  $('.counter-value').text("0");
  circle = new ProgressBar.Circle('#progress-container', {fill: "#FFF9F0", color: "#FCB03C", strokeWidth: 2.1})
  console.log circle
  animate = ->
    circle.set(0)
    circle.animate(1, {duration: 2000, easing: "easeInOut"})
  setInterval(animate, 2200)
  animate()




  console.log('loaded');
  generateMatrix()

  $('#addRowBtn').click ->
    addRow()
    model.rows++
  $('#removeRowBtn').click ->
    removeRow()
    model.rows--

  $('#addColumnBtn').click ->
    addColumn()
    model.cols++

  $('#removeColumnBtn').click ->
    removeColumn()
    model.cols--

  $('#startBtn').click ->
    prc_time = readPrcTime()
    min_t = parseFloat($('#min-t').val())
    max_t = parseFloat($('#max-t').val())


    #  spawning Web Worker
    worker = new Worker('worker.js')
    msg =
      N: model.rows
      L: model.cols
      prc_time: prc_time
      max_t: max_t
      min_t: min_t

    worker.onmessage = (ev)->
      switch ev.data.title
        when 'results'
          $('.eclipse').addClass('hidden')
          print_results(ev.data)
          build_diagrams(prc_time, model.cols, model.rows, ev.data.prc_start_time, ev.data.global_schedule)

        when 'progress'
          console.log '+1000 progress'
          increment_counter();


    worker.postMessage(msg)
    $('.eclipse').removeClass('hidden')
