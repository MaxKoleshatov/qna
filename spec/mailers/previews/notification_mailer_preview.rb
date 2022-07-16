class NotificationMailerPreview < ActionMailer::Preview
    def notification
      NotificationMailer.notification(User.first, Answer.first)
    end
  end