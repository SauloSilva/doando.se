module PersonHelper
  def setup_person(person)
    person.tap do |c|
      c.build_user if c.user.blank?
      c.build_address if c.address.blank?
      c.build_contact if c.contact.blank?
    end
  end

  def type_sex
    %w(Masculino Feminino)
  end
  
  def label_button
    @person.last_step? ? 'Concluir' : 'Proximo'
  end
end
