#
# vec_to_arr = (vec, cols)->
#   rows = vec.length / cols
#   arr = helpers.create2DArray(rows, cols)
#   for i in [0...rows]
#     for j in [0...cols]
#       arr[i][j] = vec[i*cols + j]
#   return arr
#
# swap = (arr, pos1, pos2)->
#     buf = arr[pos1];
#     arr[pos1] = arr[pos2];
#     arr[pos2] = buf;
#
# permutation = (arr, pos)=>
#     if (arr.length - pos == 1)
#         # new permutation found
#       @sol_checked++
#       # console.log arr
#       @sc.schedule = vec_to_arr(arr, @N)
#       cur_F = @sc.count_F();
#       # console.log cur_F, cur_F < @global_F
#       # return
#       if (cur_F < @global_F)
#         console.info "better solution found: F=", cur_F
#         @global_F = cur_F
#         @global_schedule = helpers.copy2DArray(@sc.schedule)
#
#     else
#         for i in [pos...arr.length]
#             swap(arr, pos, i);
#             permutation(arr, pos+1);
#             swap(arr, pos, i);
#     return
#
# init = =>
#   @initial_schedule = [0,1,2,3,4,5,6,7,8,9
#                       0,1,2,3,4,5,6,7,8,9
#                       0,1,2,3,4,5,6,7,8,9
#                       0,1,2,3,4,5,6,7,8,9
#                       0,1,2,3,4,5,6,7,8,9
#                       0,1,2,3,4,5,6,7,8,9]
#   @L = 6
#   @N = 10
#   prc_time = [[7,5,3,3,5,7],
#               [8,3,2,2,3,8],
#               [7,5,3,3,5,7],
#               [8,3,2,2,3,8],
#               [7,5,3,3,5,7],
#               [9,5,5,5,5,9],
#               [7,8,3,3,8,7],
#               [9,5,5,5,5,9],
#               [7,8,3,3,8,7],
#               [9,5,5,5,5,9]]
#
#   @sc = new Scheduler(@N, @L, prc_time, 0)
#
#   @global_F = 999999
#   @global_schedule = undefined
#   @sol_checked = 0
#
#
# init()
# permutation(@initial_schedule, 0)
initWorker = ->
  @importScripts('helpers.js', 'scheduler.js', 'lib/combinatorics.js')
  @onmessage = (ev) ->
    start()

start = ->
  init()
  solutions = generate_solutions()
  @postMessage({title: 'iterRequired', iters: solutions.length})
  while schedule = solutions.next()
    @sol_checked++
    @sc.schedule = schedule
    cur_F = @sc.count_F()
    if (cur_F < @global_F)
      @global_F = cur_F
      @global_schedule = @sc.schedule
      console.log 'better F found, F=', @global_F
      console.table @global_schedule
    # sending progress results
    if (@sol_checked % 10000) == 0
      @postMessage({title: 'progress'})
  @postMessage(
    title: 'results',
    res:
      global_F: @global_F,
      schedule: @global_schedule
      iterations: @sol_checked
  )


generate_solutions = ->
  pl = [0...@N]
  perms = Combinatorics.permutation(pl)
  Combinatorics.baseN(perms.toArray(), @L)

init = =>
  @L = 6;
  @N = 5;
  prc_time = [[7,5,3,3,5,7],
              [8,3,2,2,3,8],
              [7,5,3,3,5,7],
              [8,3,2,2,3,8],
              [7,5,3,3,5,7],
              [9,5,5,5,5,9],
              [7,8,3,3,8,7],
              [9,5,5,5,5,9],
              [7,8,3,3,8,7],
              [9,5,5,5,5,9]]

  @sc = new Scheduler(@N, @L, prc_time, 0)
  @global_F = 999999
  @global_schedule = undefined;
  @sol_checked = 0


initWorker()
