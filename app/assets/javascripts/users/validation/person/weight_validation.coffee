class window.WeightValidation extends BaseValidation
  constructor: ->
    super('#person_weight')

  run: ->
    if @field.val() == ''
      @setStatus('error', 'Nao pode ficar em branco')
    else
      @setStatus('valid')