class Reminder < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }

  validates :user_id, presence: true
  #validates :content, presence: true, length: { maximum: 120 }
  validate :eval_content_reminder
  validate :eval_when_activate



  private

  def eval_content_reminder
    if content.empty?
      errors.add :base, 'Contenido no puede quedar en blanco'
    elsif content.length > 120
      errors.add :base, 'El contenido no puede superar los 120 caracteres'
    end
  end

  def eval_when_activate
    if when_activate.to_s.empty?
      errors.add :base, 'Fecha/Hora no fue ingresada'
    end
    if when_activate.to_s == Time.zone.now.to_s
      errors.add :base, 'Fecha/Hora debe ser mayor a la actual'
    end
  end


end
