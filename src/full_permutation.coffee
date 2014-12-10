update_progress = ->
  @model.checked_solutions += 10000
  # @model.progress = 0.3
  @model.progress = @model.checked_solutions / @model.total_solutions
  console.log @model.progress
  @circle.set(@model.progress)
  $('#progressbar header').text((@model.progress*100).toFixed(2) + '%')

print_results = (res)->
  console.log(res)

init_progressbar = (total)->
  @model.total_solutions = total
  $('#progressbar header').text(0)
  console.log @model.total_solutions

init = =>
  console.log 'starting'
  @model =
    total_solutions: 0,
    checked_solutions: 0,
    cur_global_F: 0,
    cur_global_schedule: 0
    progress: 0

  worker = new Worker('full_permutation_worker.js')

  @circle = new ProgressBar.Circle('#progressbar', {color: "rgb(161, 0, 255)", trailColor: "#f4f4f4", strokeWidth: 2.1});
  @circle.set(0.3)

  worker.postMessage('start')

  worker.onmessage = (ev)->
    # console.log(ev.data)
    switch ev.data.title
      when 'progress' then update_progress()
      when 'iterRequired' then init_progressbar(ev.data.iters)
      when 'results' then print_results(ev.data.res)




$ init
