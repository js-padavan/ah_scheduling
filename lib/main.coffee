

model =
  rows: 5
  cols: 6
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



$  ->
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
        when 'results' then print_results(ev.data)
        when 'progress' then console.log '+1000 progress'


    worker.postMessage(msg)
