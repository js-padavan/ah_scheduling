console.log 'worker started'

importScripts('helpers.js', 'scheduler.js', 'method.js')

init = =>
  @onmessage = (ev)->
    console.log(ev)
    res = start(ev.data.N, ev.data.L, ev.data.prc_time, ev.data.max_t, ev.data.min_t)
    res.title = 'results'
    postMessage(res)


progress_notification = ->
  postMessage({title: 'progress', desc: 'thousand iterations pass'})


start =  (N, L, prc_time, max_t, min_t)->
  sc = new Scheduler(N, L, prc_time, 0)
  method = new Method(sc)
  return method.start(min_t, max_t, progress_notification)



init();
