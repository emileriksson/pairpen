class EmailTemplate < ApplicationRecord
  TEMPLATE_NAMES = %w[verification approval rejection match_notification].freeze
  
  validates :name, presence: true, uniqueness: true, inclusion: { in: TEMPLATE_NAMES }
  validates :subject, presence: true
  validates :body, presence: true
  
  def render_with_variables(variables = {})
    rendered_subject = subject
    rendered_body = body
    
    variables.each do |key, value|
      placeholder = "{{#{key}}}"
      rendered_subject = rendered_subject.gsub(placeholder, value.to_s)
      rendered_body = rendered_body.gsub(placeholder, value.to_s)
    end
    
    {
      subject: rendered_subject,
      body: rendered_body
    }
  end
end
