class Reminder < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :not_empty_when_activate

=begin
  def greater_than_now
    if when_activate <= DateTime.now
      errors.add :base, 'Cuando activar debe ser mayor a la fecha actual.'
    end
  end
=end

  def not_empty_when_activate
    if when_activate.nil? or when_activate <= DateTime.now
      errors.add :base, 'Cuando activar no puede quedar en blanco o la fecha es menor a la actual.'
    end
  end
end
