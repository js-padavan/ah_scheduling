times = [[1,2,3], [4,5,6]]
@sc = new Scheduler(3, 2, times, 2)
console.log sc
do sc.generate_initial_schedule
do sc.create_prc_orders
helpers.printVectorOfMatr sc.prc_orders
