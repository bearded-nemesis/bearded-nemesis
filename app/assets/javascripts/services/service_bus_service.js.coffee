#window.beard.services.factory(
#  'busService', () ->
#      postal.channel()
#)

window.beard.services.factory(
  'busService'
  [
    () ->
      postal.channel()
  ]
)