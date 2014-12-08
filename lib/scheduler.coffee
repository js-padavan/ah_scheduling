
class @Scheduler
  constructor: (@N, @L, @prc_time, @f_type)->
      @schedule = undefined
      @prc_orders = undefined
      @prc_start_time = undefined
      @generate_initial_schedule()

  generate_initial_schedule: ->
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


  # generate_new_schedule: ->
  #   @schedule = helpers.copy2DArray(@schedule)
  #   for l in [0...@L]
  #     loop
  #       first_index = parseInt(Math.random()*1000%@N)
  #       second_index = parseInt(Math.random()*1000%@N)
  #       break if first_index < second_index
  #
  #     buf = @schedule[l][first_index]
  #     @schedule[l][first_index] = @schedule[l][second_index]
  #     @schedule[l][second_index] = buf
  #
  #   return @schedule

  # generate_new_schedule: ->
  #   @schedule = helpers.copy2DArray(@schedule)
  #   loop
  #     first_index = parseInt(Math.random()*1000%@N)
  #     second_index = parseInt(Math.random()*1000%@N)
  #     break if first_index < second_index
  #   for l in [0...@L]
  #     buf = @schedule[l][first_index]
  #     @schedule[l][first_index] = @schedule[l][second_index]
  #     @schedule[l][second_index] = buf
  #
  #   return @schedule

  # generate_new_schedule: ->
  #   @schedule = helpers.copy2DArray(@schedule)
  #   loop
  #     first_index = parseInt(Math.random()*1000%@N)
  #     second_index = parseInt(Math.random()*1000%@N)
  #     break if first_index < second_index
  #   l = parseInt(Math.random()*1000%@L)
  #
  #   # for l in [0...@L]
  #   buf = @schedule[l][first_index]
  #   @schedule[l][first_index] = @schedule[l][second_index]
  #   @schedule[l][second_index] = buf
  #
  #   return @schedule

  generate_new_schedule: ->
    @schedule = helpers.copy2DArray(@schedule)
    loop
      first_index = parseInt(Math.random()*1000%@N)
      second_index = parseInt(Math.random()*1000%@N)
      break if first_index != second_index
    P = Math.random()

    if P < 0.3
      for l in [0...@L]
        buf = @schedule[l][first_index]
        @schedule[l][first_index] = @schedule[l][second_index]
        @schedule[l][second_index] = buf
    else
      l = parseInt(Math.random()*1000%@L)
      buf = @schedule[l][first_index]
      @schedule[l][first_index] = @schedule[l][second_index]
      @schedule[l][second_index] = buf

    return @schedule


  calc_prc_start_time_1: ->

      t = helpers.create2DArray(@N, @N)
      for row in [1...@N]
        elem = 0
        for j in [0...row]
          for h in [0...@N]
            elem += @prc_time[h][0] * @prc_orders[0][h][j]

        for i in [0...@N]
          if @prc_orders[0][i][row] == 1
            t[row][i] = elem

      return t

  calc_prc_start_time_l: (l)->

    t = helpers.create2DArray(@N, @N)
     # computing first string
    for i in [0...@N]
      if @prc_orders[l][i][0] == 0
        continue
      elem = 0
      for h in [0...@N]
        elem += @prc_orders[l-1][i][h] * (@prc_start_time[l-1][h][i] + @prc_time[i][l-1])
      t[0][i] = elem

      #computing all other strings
    for j in [1...@N]
      for i in [0...@N]
        if @prc_orders[l][i][j] == 0
          continue

        elem1 = 0
        elem2 = 0

        for h in [0...@N]
          elem1 += @prc_orders[l-1][i][h] * (@prc_start_time[l-1][h][i] + @prc_time[i][l-1])

        for h in [0...@N]
          elem2 += @prc_orders[l][h][j-1] * (t[j-1][h] + @prc_time[h][l])

        t[j][i] = if elem2 > elem1 then elem2 else elem1

    return t

  calc_prc_start_time: ->
    @prc_start_time = Array.apply(null, new Array(@L))
    @prc_start_time[0] = @calc_prc_start_time_1()
    for l in [1...@L]
      @prc_start_time[l] = @calc_prc_start_time_l(l)

    return @prc_start_time

    # F - hardware downtime
  count_F1: ->
    part1 = 0
    part2 = 0

    for l in [1...@L]
      for i in [0...@N]
        part1 += @prc_start_time[l][0][i] * @prc_orders[l][i][0]

    for l in [1...@L]
      for j in [1...@N]
        for i in [0...@N]
          part2 += @prc_start_time[l][j][i] * @prc_orders[l][i][j] -
                  (@prc_start_time[l][j-1][i] + @prc_time[i][l]) * @prc_orders[l][i][j-1]

    return part1 + part2

    # F - processing time
  count_F2: ->
    F = 0
    l = @L - 1
    for i in [0...@N]
      F += @prc_start_time[l][@N-1][i] + @prc_orders[l][i][@N-1] * @prc_time[i][l]

    return F

  count_F: ->
    @prc_orders = @create_prc_orders()
    @prc_start_time = @calc_prc_start_time()
    switch @f_type
      when 0 then @count_F1()
      when 1 then @count_F2()
