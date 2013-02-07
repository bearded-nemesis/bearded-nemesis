class Beard.Widgets.KeyManager
  constructor: () ->
    @codeRegistry = []
    @keyRegistry = []
    @eventRegistry = []

    document.onkeydown = this._add
    document.onkeyup = this._remove

  _add: (evt) =>
    code = this._getCode evt
    key = this._getKey(code).toUpperCase()

    if (!@codeRegistry.inArray(code) && !@keyRegistry.inArray(key))
      @codeRegistry.push code
      @keyRegistry.push key

    this._press evt

  _getCode: (evt) ->
    evt = window.event || evt
    return evt.keyCode || evt.which

  _getKey: (code) ->
    return String.fromCharCode code

  _press: (evt) =>
    mods = []

    mods.push "ALT" if evt.altKey == true
    mods.push "CTRL" if evt.ctrlKey == true
    mods.push "SHIFT" if evt.shiftKey == true

    for evt in @eventRegistry
      allPressed = true
      keys = []

      if evt.key.indexOf('+') != -1
        keys = evt.key.split('+')

        for key in keys
          allPressed = false unless @keyRegistry.inArray(key) && @codeRegistry.inArray(parseInt(key))
      else if !@keyRegistry.inArray(evt.key) && !@codeRegistry.inArray(parseInt(evt.key))
        allPressed = false
      else
        keys.push evt.key

      if allPressed
        modsPressed = true

        if evt.mods && evt.mods.length > 0
          for mod in evt.mods
            modsPressed = false unless mods.inArray(mod)

        if modsPressed
          evt.keyDown evt if typeof(evt.keyDown) == "function"

          for key in keys
            ndx = @keyRegistry.indexOf key
            @keyRegistry.splice ndx, 1
            @codeRegistry.splice ndx, 1

  _remove: (evt) =>
    code = this._getCode(evt)

    ndx = @codeRegistry.indexOf code
    @codeRegistry.splice ndx, 1
    @keyRegistry.splice ndx, 1

  register: (id, key, keyDown, mods) =>
    mods = mods.split(',') if mods

    evt = {
      id: id,
      key: key.toUpperCase(),
      keyDown: keyDown,
      mods: mods
    }

    @eventRegistry.push evt


# Array extensions
if(!Array.prototype.inArray)
  Array.prototype.inArray = (needle) ->
    for value in this
      return true if value == needle

    return false

if (!Array.prototype.indexOf)
  Array.prototype.indexOf = (elt) ->
    len = this.length;

    for from in len
      return from if from in this && this[from] == elt

    return -1