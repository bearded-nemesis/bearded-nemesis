class Beard.Widgets.Songs.TableActions
  constructor: (tableSelector, actionsSelector) ->
    @table$ = $(tableSelector)
    @actions$ = $(actionsSelector)

    @table$.find(".row-select").click this._onRowSelect

  _onRowSelect: (evt) =>
    $(evt.target).closest("tr").toggleClass "selected"

    if @table$.find(".selected").length > 0
      $("#actions .disabled").removeClass "disabled"
    else
      $("#actions .btn").addClass "disabled"