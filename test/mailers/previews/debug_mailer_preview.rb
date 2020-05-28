# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/debug_mailer
class DebugMailerPreview < ActionMailer::Preview
  def email
    DebugMailer.with(message: Live.first)
               .email
  end
end
