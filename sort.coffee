fs = require 'fs'
ico = require 'ico'
colors = require 'colors'
_ = require 'underscore'
tar  = []
fs.readFile __dirname + '/cptardata.txt', (err, data)->
  list = data.toString().split '\n'
  index = 0
  for line in list
    pq = Number(line.split(' ')[0])
    if pq isnt 0
      point =
        index: index++
        q: pq 
        guage: line.split(' ')[1]
      tar.push point

  sorted = _.sortBy tar, 'q'
  i = Number sorted.length
  previous = 0
  holdrank = 0
  for item in sorted
    if previous is item.q
      item.rank = holdrank
      i--
    else
      item.rank = i--
      holdrank = item.rank
    previous = item.q

  indexed = _.sortBy sorted, 'index'
  for point in indexed
    point.ri = String(Number((point.rank + 1)/point.guage).toFixed 2).green
  for point in indexed
    console.log point.q + " " + point.guage + " " + String(point.rank).red + " " + point.ri
