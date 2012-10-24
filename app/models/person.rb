class Person
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slugify

  field :donor, type: Boolean
  field :name, type: String
  field :surname, type: String
  field :sex, type: String
  field :weight, type: Float
  field :height, type: Float
  field :birthday, type: Date
  field :observations, type: String

  #access control
  attr_accessible :sex, :donor, :name, :surname, :weight, :height, :birthday,
    :observations, :address_attributes, :contact_attributes, :user_attributes,
    :blood, :blood_id, :lat, :lng, :loc

  #relationship
  belongs_to :blood
  belongs_to :company
  has_many :person_notifications
  has_one :address, as: :addressable, dependent: :destroy, autosave: true
  has_one :contact, as: :contactable, dependent: :destroy, autosave: true
  has_one :user, as: :authenticable, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :address, :contact, :user, allow_destoy: true

  #validations
  validates :donor, inclusion: { in: %w(true false) }
  validates :sex, inclusion: { in: %w(0 1) }
  validates_presence_of :name, :weight, :height, :surname, :sex, :birthday,
                        :contact, :address, :blood, :user
  validates :name, length: { minimum: 2, maximum: 30 }
  validates :weight, length: { minimum: 2, maximum: 3 }
  validates :height, length: { minimum: 3, maximum: 3 }
  validates :weight, :height, numericality: true

  #validate birtdhate
  def birthdate=value
    super value
  rescue
    nil
  end

  #scopes
  scope :actives, where: { active: true }
  scope :donors, where: { donor: true }

  private
  def generate_slug
    name.parameterize
  end
end