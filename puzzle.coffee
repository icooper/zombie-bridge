# class for escaping person
class Escapee

  # create escapee with defined initial crossing time
  constructor: (crossing_time, id) ->
    @safe = no
    @time = @initial_time = parseInt crossing_time
    @id = id

  # cross, but time increases by 20% for next time
  cross: ->
    crossing_time = @time
    @safe = not @safe
    @time *= 1.2
    crossing_time

  # decrease time to cross by 5 seconds for every minute of rest
  rest: (resting_minutes) ->
    @time -= resting_minutes * (5 / 60)
    @time = @initial_time if @time < @initial_time

  # return status as string
  status: ->
    "#{@id}: " + (if @safe then '->' else '<-') + " (#{@time})"

# round a number to the specified decimal places (defaults to 2)
round = (number, decimals) ->
  decimals ?= 2
  Math.round(number * Math.pow(10, decimals)) / Math.pow(10, decimals)

# function to choose the next escapee(s) based on the fastest available
choose = (escapees, to_safety) ->

  # filter eligible escapees
  eligible = escapees.filter (escapee) ->
    escapee.safe isnt to_safety

  # sort eligible escapees by time
  eligible.sort (a, b) ->
    a.time - b.time

  # return the fastest one or two escapees, depending on direction
  count = if to_safety then Math.min eligible.length - 1, 1 else 0
  eligible[0..count].map (escapee) -> escapee.id

# move escapees
cross = (escapees, to_safety) ->

  # choose escapees to cross
  chosen = choose escapees, to_safety

  # cross the chosen escapee(s) and record the time involved
  time = 0
  escapees.forEach (escapee) ->
    if chosen.indexOf(escapee.id) isnt -1
      time = Math.max escapee.cross(), time

  # rest the remaining escapee(s)
  escapees.forEach (escapee) ->
    if chosen.indexOf(escapee.id) is -1
      escapee.rest time

  # print out a line about who crossed
  console.log (if to_safety then '-> ' else '<- ') +
              chosen.join(' ') +
              " (#{round time})"

  # return the time taken
  time

# check to see if all are safe
all_safe = (escapees) ->
  escapees.reduce (previous, escapee) ->
    escapee.safe and previous
  , yes

# open up stdin
stdin = process.openStdin()
stdin.setEncoding 'utf8'

# read data from stdin
stdin.on 'data', (chunk) ->

  # create escapees based on input
  escapees = []
  i = 0
  for time in chunk.match /\d+/g
    escapees.push new Escapee time, i++

  # set initial time and direction
  to_safety = yes
  time = 0

  # keep crossing until they're all safe
  while not all_safe escapees
    time += cross escapees, to_safety
    to_safety = not to_safety

  # print out the final time
  console.log round time

  # and quit
  process.exit()
