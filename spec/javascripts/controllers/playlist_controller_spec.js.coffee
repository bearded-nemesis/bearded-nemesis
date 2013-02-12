describe 'PaylistController', ->
  beforeEach ->
    @scope = { model: { playlist: 3 } }

    @bus = {
      publish: (name, data) ->

    }

  it 'should send message when ui is requested', ->
    spyOn @bus, 'publish'

    controller = new beard.impl.PlaylistController @scope, @bus
    controller.showAddSong()

    expect(@bus.publish).toHaveBeenCalled()
    expect(@bus.publish.mostRecentCall.args[0]).toEqual("playlist.ui.showAddSong");
    expect(@bus.publish.mostRecentCall.args[1].playlist).toEqual(3)
