# require "rails_helper"

# RSpec.describe DailyDigestMailer, type: :mailer do
#   describe "digest" do
#     let(:mail) { DailyDigestMailer.digest }

#     it "renders the headers" do
#       expect(mail.subject).to eq("Digest")
#       expect(mail.to).to eq(["to@example.org"])
#       expect(mail.from).to eq(["from@example.com"])
#     end

#     it "renders the body" do
#       expect(mail.body.encoded).to match("Hi")
#     end
#   end

# end

require 'rails_helper'

RSpec.describe DailyDigestMailer, type: :mailer do
  describe 'digest' do
    let(:user) { create(:user, admin: true) }
    let(:mail) { DailyDigestMailer.digest(user) }

    it 'mails attributes' do
      expect(mail.subject).to eq('Digest')
      expect(mail.from).to eq(['from@example.com'])
      expect(mail.to).to eq([user.email])
    end

    it 'mails body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
