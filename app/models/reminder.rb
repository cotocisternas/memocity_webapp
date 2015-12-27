class Reminder < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :not_empty, :greater_than_now

  private

  def not_empty
    errors.add :base, 'Cuando activar no puede quedar en blanco.' if when_activate.nil?
  end

  def greater_than_now
    errors.add :base, 'Cuando activar debe ser mayor a la fecha actual.' if when_activate <= Time.now
  end
end
