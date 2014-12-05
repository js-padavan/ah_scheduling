times = [[3,5,7], [2,3,8], [3,5,7], [2,3,8],[3,5,7]]
@sc = new Scheduler(5, 3, times, 0)
@method = new Method(@sc)
F = @method.start(0.1, 10)
console.log F
