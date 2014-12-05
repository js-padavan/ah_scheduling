
class Method
  constructor: (@scheduler)->


  decrease_temperature: (t_max, i)->
    return t_max / (1 + 0.01 * i)

  is_transition: (dF, T)->
    P = Math.exp(-dF / T)
    rand = Math.random()
    if rand < P then true else false

  start: (t_min, t_max)->
    t_cur = t_max
    @iteration = 0
    @global_F = cur_F = @scheduler.count_F()
    @global_schedule = @scheduler.schedule
    previous =
      F: @global_F
      schedule: @global_schedule
      # optimization cycle
    while t_cur > t_min
      @iteration++
      @scheduler.generate_new_schedule()
      cur_F = @scheduler.count_F()

      if (cur_F < @global_F)
        @global_F = cur_F
        @global_schedule = @scheduler.schedule
        console.table(@scheduler.schedule)
      else
        if @is_transition(cur_F - @global_F, t_cur)
          console.log('transition to worse')
        else
          @scheduler.schedule = @global_schedule

      previous.F = cur_F
      previous.schedule = @scheduler.schedule

      t_cur = @decrease_temperature(t_max, @iteration)

    @scheduler.schedule = @global_schedule
    @global_F = @scheduler.count_F()
    helpers.printVectorOfMatr(@scheduler.prc_start_time)
    console.table(@scheduler.schedule)
    return @global_F

@Method = Method
