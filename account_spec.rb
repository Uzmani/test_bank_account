require "rspec"

require_relative "account"

describe Account do
  let(:invalid_number) { "11234567" }
  let(:valid_number) { "1123456790" }
  let(:account_invalid) { Account.new(invalid_number) }
  let(:account_valid) { Account.new(valid_number) }
  describe "#initialize" do
    it "should raise an error" do
      expect {account_invalid.acct_number}.to raise_error(InvalidAccountNumberError)
    end
    it "should not raise an error" do
      expect {account_valid.acct_number}.to_not raise_error
    end
  end

  describe "#transactions" do
    it "should default at zero" do
      expect(account_valid.transactions.first).to eq 0
    end
  end

  describe "#balance" do
    it "should equal to 0" do
      expect(account_valid.balance).to eq 0
    end
  end

  describe "#account_number" do
    it "should hide the account number" do
      expect(account_valid.acct_number).to_not eq valid_number
    end
  end

  describe "deposit!" do
    it "returns correct balance" do
      expect(account_valid.deposit!(10)).to eq account_valid.balance
      expect {account_valid.deposit!(10)}.to change {account_valid.balance}
    end
  end

  describe "#withdraw!" do
    it "raises OverdraftError" do
      expect {account_valid.withdraw!(5)}.to raise_error(OverdraftError)
    end
    it "returns correct balance" do
      account_valid.deposit!(10)
      expect(account_valid.withdraw!(5)).to eq account_valid.balance
  end
  end
end