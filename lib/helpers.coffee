
class Helpers

  create2DArray: (rows, cols)->
    arr = Array.apply(null, new Array(rows))
    for i in [0...rows]
      arr[i] = Array.apply(null, new Array(cols)).map(Number.prototype.valueOf, 0)
    return arr

  printVectorOfMatr: (vec)->
    vec_size = vec.length
    rows = vec[0].length
    cols = vec[0][0].length
    for l in [0...vec_size]
      console.table(vec[l])

    return null

@helpers = new Helpers();
