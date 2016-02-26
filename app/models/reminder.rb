class Reminder < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  #validates :content, presence: true, length: { maximum: 140 }
  validate :contentReminder
  validate :eval_when_activate



  private

  def contentReminder
    if content.empty?
      errors.add :base, 'Contenido no puede quedar en blanco'
    elsif content.length >= 140
      errors.add :base, 'El contenido no puede superar los 140 caracteres'
    end
  end

  def eval_when_activate
    if when_activate.nil?
      errors.add :base, 'Cuando activar no puede quedar en blanco'
    end
    if when_activate <= Time.zone.now
      errors.add :base, 'Fecha/Hora debe ser mayor a la actual'
    end
  end


end
