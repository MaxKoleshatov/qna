require 'rails_helper'

RSpec.describe NotificationJob, type: :job do
  let(:service) { double('Services::Notification') }

  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  before do
    allow(Notification).to receive(:new).and_return(service)
  end

  it '#send_notification' do
    expect(service).to receive(:send_notification)
    NotificationJob.perform_now(answer)
  end
end