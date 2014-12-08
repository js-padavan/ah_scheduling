
class Method
  constructor: (@scheduler)->


  decrease_temperature: (t_max, i)->
    return t_max / (1 + 0.01 * i)

  is_transition: (dF, T)->
    P = Math.exp(-dF / T)
    # P = 0.5
    rand = Math.random()
    # console.log P, rand
    if rand < P then true else false

  start: (t_min, t_max)->
    t_cur = t_max
    @iteration = 0
    @global_F = cur_F = @scheduler.count_F()
    console.info 'initial F=' + @global_F
    initial_F = @global_F
    @global_schedule = @scheduler.schedule
    previous =
      F: @global_F
      schedule: @global_schedule
      # optimization cycle
    while t_cur > t_min
      @iteration++
      @scheduler.generate_new_schedule()
      cur_F = @scheduler.count_F()
      if (@iteration % 1000) == 0
        console.info "*1000 iterations"
      if (cur_F < @global_F)
        @global_F = cur_F
        @global_schedule = @scheduler.schedule
        console.info 'better solution found'
      else
        if @is_transition(cur_F - @global_F, t_cur)
          # console.info 'transition to worse'
        else
          @scheduler.schedule = @global_schedule

      previous.F = cur_F
      previous.schedule = @scheduler.schedule

      t_cur = @decrease_temperature(t_max, @iteration)

    @scheduler.schedule = @global_schedule
    @global_F = @scheduler.count_F()
    helpers.printVectorOfMatr(@scheduler.prc_start_time)
    console.table(@scheduler.schedule)
    res =
      global_F: @global_F
      global_schedule: @global_schedule
      initial_F: initial_F
    return res

@Method = Method
