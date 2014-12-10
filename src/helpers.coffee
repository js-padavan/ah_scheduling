
class Helpers

  create2DArray: (rows, cols)->
    # arr = Array.apply(null, new Array(rows))
    arr = new Array(rows)
    for i in [0...rows]
      # arr[i] = Array.apply(null, new Array(cols)).map(Number.prototype.valueOf, 0)
      arr[i] = new Uint16Array(cols)
    return arr

  copy2DArray: (arr)->
    rows = arr.length
    cols = arr[0].length
    res = @create2DArray(rows, cols)
    for i in [0...rows]
      for j in [0...cols]
        res[i][j] = arr[i][j]
    return res

  printVectorOfMatr: (vec)->
    vec_size = vec.length
    rows = vec[0].length
    cols = vec[0][0].length
    for l in [0...vec_size]
      console.table(vec[l])

    return null

@helpers = new Helpers();
