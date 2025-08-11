# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create an admin user for development
if Rails.env.development?
  admin = Admin.find_or_create_by!(email: 'admin@pairpen.com') do |a|
    a.name = 'Admin User'
    a.password = 'password123'
    a.password_confirmation = 'password123'
  end
  
  puts "Created admin user: #{admin.email} with password: password123"
end

# Create email templates
email_templates = [
  {
    name: 'verification',
    subject: 'Please verify your pen pal application',
    body: 'Thank you for applying! Please click the link below to verify your email: {{verification_link}}'
  },
  {
    name: 'approval',
    subject: 'Your pen pal application has been approved!',
    body: 'Great news! Your application has been approved. You are now in our matching pool. Check your status: {{status_link}}'
  },
  {
    name: 'rejection',
    subject: 'Your pen pal application status',
    body: 'Thank you for your interest. Unfortunately, your application was not approved at this time. You can apply again in the future.'
  },
  {
    name: 'match_notification',
    subject: "You've been matched with a pen pal!",
    body: 'Congratulations! You have been matched with {{match_email}}. Happy writing!'
  }
]

email_templates.each do |template_data|
  EmailTemplate.find_or_create_by!(name: template_data[:name]) do |template|
    template.subject = template_data[:subject]
    template.body = template_data[:body]
  end
end

puts "Created #{EmailTemplate.count} email templates"
