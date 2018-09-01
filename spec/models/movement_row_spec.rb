require "rails_helper"

RSpec.shared_examples "a parsed movement row" do
  it "parses iban" do
    byebug
    expect(movement.iban).to eql(expected_values[:iban])
  end

  it "parses number" do
    expect(movement.number).to eql(expected_values[:number])
  end

  it "parses date" do
    expect(movement.date).to eql(expected_values[:date])
  end

  it "parses amount" do
    expect(movement.amount).to eql(expected_values[:amount])
  end

  it "parses debit" do
    expect(movement.debit?).to eql(expected_values[:debit])
  end

  it "parses credit" do
    expect(movement.credit?).to eql(expected_values[:credit])
  end

  it "parses money_transaction" do
    expect(movement.money_transaction?).to eql(expected_values[:money_transaction])
  end

  it "parses bank_communication" do
    expect(movement.bank_communication?).to eql(expected_values[:bank_communication])
  end

  it "parses communication" do
    expect(movement.communication).to eql(expected_values[:communication])
  end

  it "finds movement type" do
    expect(movement.movement_type).to eql(expected_values[:movement_type])
  end
end

RSpec.describe MovementRow do
  context "rabobank movements in ing export" do
    let(:csv_row) { csv_rows("rabobank_#{fixture_name}").first }
    let(:movement) { MovementRow.new(csv_row) }

    describe "banking fee" do
      let(:fixture_name) { "banking_fee" }
      let(:expected_values) do
        {
          iban: nil,
          number: "105",
          date: "03/04/2017",
          amount: -3.56,
          debit: true,
          credit: false,
          money_transaction: true,
          bank_communication: false,
          communication: nil,
          movement_type: "banking_fee"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    # TODO
    describe "interests" do
    end

    # TODO
    describe "bank communication" do
    end

    # TODO
    describe "hardware order" do
    end

    # TODO
    describe "domain name" do
    end

    describe "hosting i3d" do
      let(:fixture_name) { "i3d" }
      let(:expected_values) do
        {
          iban: "NL51INGB0004490008",
          number: "121",
          date: "10/04/2017",
          amount: -173.03,
          debit: true,
          credit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "F17-0100014443",
          movement_type: "hosting"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    # TODO
    describe "moniteur" do
    end

    # TODO
    describe "network" do
    end

    # TODO
    describe "hardware order member" do
    end

    describe "vpn" do
      let(:fixture_name) { "vpn" }
      let(:expected_values) do
        {
          iban: "BE52223123456789",
          number: "106",
          date: "03/04/2017",
          amount: 10.0,
          debit: false,
          credit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "Doe VPN",
          movement_type: "vpn"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "vpn from abroad" do
      let(:fixture_name) { "vpn_abroad" }
      let(:expected_values) do
        {
          iban: "FR7612345678123456781234123",
          number: "107",
          date: "03/04/2017",
          amount: 8.0,
          debit: false,
          credit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "B12ADEB34FC5DFC",
          movement_type: "vpn"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    # TODO
    describe "domain name member" do
    end
  end

  context "ing movements in ing export" do
  end
end
