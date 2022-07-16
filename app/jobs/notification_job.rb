class NotificationJob < ApplicationJob
    queue_as :default
  
    def perform(answer)
      Notification.new.send_notification(answer)
    end
  end