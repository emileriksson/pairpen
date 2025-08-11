require "rails_helper"

RSpec.describe PenPalMailer, type: :mailer do
  describe "verification_email" do
    let(:mail) { PenPalMailer.verification_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Verification email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "approval_email" do
    let(:mail) { PenPalMailer.approval_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Approval email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "rejection_email" do
    let(:mail) { PenPalMailer.rejection_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Rejection email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe "match_notification_email" do
    let(:mail) { PenPalMailer.match_notification_email }

    it "renders the headers" do
      expect(mail.subject).to eq("Match notification email")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
