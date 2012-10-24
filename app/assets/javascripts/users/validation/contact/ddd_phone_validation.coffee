class window.DddPhoneValidation extends BaseValidation
  constructor: ->
    super('input#person_contact_attributes_ddd_phone')

  run: ->
    if is_blank('input#person_contact_attributes_ddd_cellphone')
      switch
        when is_blank(@field) then @setStatus('error', 'Nao pode ficar em branco')
        when not_number(@field) then @setStatus('error', 'Nao e numero')
        when @field.val().length > 2 || @field.val().length < 2  then @setStatus('error', 'Nao e valido')
        else
          @setStatus('valid')
    else
      @setStatus('valid')