class Reminder < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :eval_when_activate

  def eval_when_activate
    if when_activate.nil?
      errors.add :base, 'Cuando activar no puede quedar en blanco.'
    elsif when_activate >= DateTime.now
      errors.add :base, 'Fecha/Hora debe ser mayor a la actual.'
    end
  end
end
