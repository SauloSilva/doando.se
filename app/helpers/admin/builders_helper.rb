module Admin::BuildersHelper
  def setup_company(company)
    company.tap do |c|
      c.build_user if c.user.blank?
      c.build_address if c.address.blank?
      c.build_contact if c.contact.blank?
    end
  end

  def setup_person(person)
    person.tap do |c|
      c.build_user if c.user.blank?
      c.build_address if c.address.blank?
      c.build_contact if c.contact.blank?
    end
  end
end