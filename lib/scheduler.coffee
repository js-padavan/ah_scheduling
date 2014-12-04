
class @Scheduler
  constructor: (@N, @L, @prc_time, @f_type)->
      @schedule = undefined
      @prc_time = undefined

  generate_initial_schedule: ->
      console.log helpers
      @schedule = helpers.create2DArray(@L, @N)
      for l in [0...@L]
        for i in [0...@N]
          @schedule[l][i] = i
      return @schedule

  create_prc_orders: (sc)->
    sc = sc || @schedule
    @prc_orders = Array.apply(null, new Array(@L));
    for l in [0...@L]
      @prc_orders[l] = helpers.create2DArray(@N, @N)
      for i in [0...@N]
        value = sc[l][i]
        @prc_orders[l][i][value] = 1;

    return @prc_orders


  generate_new_schedule: ->
    for l in [0...@L]
      loop
        first_index = Math.rand() % @N
        second_index = Math.rand() % @N
        break if first_index < second_index

      buf = @schedule[l][first_index]
      @schedule[l][first_index] = @schedule[l][second_index]
      @schedule[l][second_index] = buf

    return @schedule

  
