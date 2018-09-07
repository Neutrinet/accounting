require "rails_helper"

RSpec.shared_examples "a parsed movement row" do
  it "parses iban" do
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
    expect(movement.credit?).to eql(!expected_values[:debit])
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
  context "recordbank movements in ing export" do
    let(:csv_row) { csv_rows("recordbank_#{fixture_name}").first }
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

    describe "hardware order" do
      let(:fixture_name) { "olimex" }
      let(:expected_values) do
        {
          iban: "BG89FINV91501016150445",
          number: "245",
          date: "01/08/2017",
          amount: -243.42,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: ".W-TB010817",
          movement_type: "hardware_order"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "domain name" do
      let(:fixture_name) { "gandi" }
      let(:expected_values) do
        {
          iban: "LU960030878793070000",
          number: "331",
          date: "18/10/2017",
          amount: -200.0,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "30940322",
          movement_type: "domain_name"
        }
      end

      it_behaves_like "a parsed movement row"
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

    describe "network" do
      let(:fixture_name) { "gitoyen" }
      let(:expected_values) do
        {
          iban: "FR7610278060310002045230163",
          number: "99",
          date: "23/03/2018",
          amount: -15.0,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "FA1803-0710",
          movement_type: "network"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "hardware order member 1" do
      let(:fixture_name) { "hardware_order_1" }
      let(:expected_values) do
        {
          iban: "BE12123456781212",
          number: "98",
          date: "21/03/2018",
          amount: 6.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "cable SATA associe a commande ?122",
          movement_type: "hardware_order_member"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "hardware order member 2" do
      let(:fixture_name) { "hardware_order_2" }
      let(:expected_values) do
        {
          iban: "BE12123456789101",
          number: "132",
          date: "17/04/2018",
          amount: 200.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "order .131",
          movement_type: "hardware_order_member"
        }
      end

      it_behaves_like "a parsed movement row"
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
    let(:csv_row) { csv_rows("ing_#{fixture_name}").first }
    let(:movement) { MovementRow.new(csv_row) }

    describe "vpn" do
      let(:fixture_name) { "vpn" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "191",
          date: "19/06/2018",
          amount: 8.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "cotisation asbl + 1 mois de VPN Info personnelle: 20180619CEC101002598-003667",
          movement_type: "vpn"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    # describe "hardware order" do
    #   let(:fixture_name) { "olimex" }
    #   let(:expected_values) do
    #     {
    #       iban: "BG89FINV91501016150445",
    #       number: "245",
    #       date: "01/08/2017",
    #       amount: -243.42,
    #       debit: true,
    #       money_transaction: true,
    #       bank_communication: false,
    #       communication: ".W-TB010817",
    #       movement_type: "hardware_order"
    #     }
    #   end

    #   it_behaves_like "a parsed movement row"
    # end

    # describe "domain name" do
    #   let(:fixture_name) { "gandi" }
    #   let(:expected_values) do
    #     {
    #       iban: "LU960030878793070000",
    #       number: "331",
    #       date: "18/10/2017",
    #       amount: -200.0,
    #       debit: true,
    #       money_transaction: true,
    #       bank_communication: false,
    #       communication: "30940322",
    #       movement_type: "domain_name"
    #     }
    #   end

    #   it_behaves_like "a parsed movement row"
    # end

    describe "hosting i3d" do
      let(:fixture_name) { "i3d" }
      let(:expected_values) do
        {
          iban: "NL51INGB0004490008",
          number: "243",
          date: "07/08/2018",
          amount: -173.03,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "Client no.: K126687 invoice no.: F18-0100017375",
          movement_type: "hosting"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    # describe "hardware order member 1" do
    #   let(:fixture_name) { "hardware_order_1" }
    #   let(:expected_values) do
    #     {
    #       iban: "BE12123456781212",
    #       number: "98",
    #       date: "21/03/2018",
    #       amount: 6.0,
    #       debit: false,
    #       money_transaction: true,
    #       bank_communication: false,
    #       communication: "cable SATA associe a commande ?122",
    #       movement_type: "hardware_order_member"
    #     }
    #   end

    #   it_behaves_like "a parsed movement row"
    # end

    # describe "hardware order member 2" do
    #   let(:fixture_name) { "hardware_order_2" }
    #   let(:expected_values) do
    #     {
    #       iban: "BE12123456789101",
    #       number: "132",
    #       date: "17/04/2018",
    #       amount: 200.0,
    #       debit: false,
    #       money_transaction: true,
    #       bank_communication: false,
    #       communication: "order .131",
    #       movement_type: "hardware_order_member"
    #     }
    #   end

    #   it_behaves_like "a parsed movement row"
    # end

    # describe "vpn" do
    #   let(:fixture_name) { "vpn" }
    #   let(:expected_values) do
    #     {
    #       iban: "BE52223123456789",
    #       number: "106",
    #       date: "03/04/2017",
    #       amount: 10.0,
    #       debit: false,
    #       money_transaction: true,
    #       bank_communication: false,
    #       communication: "Doe VPN",
    #       movement_type: "vpn"
    #     }
    #   end

    #   it_behaves_like "a parsed movement row"
    # end

    # describe "vpn from abroad" do
    #   let(:fixture_name) { "vpn_abroad" }
    #   let(:expected_values) do
    #     {
    #       iban: "FR7612345678123456781234123",
    #       number: "107",
    #       date: "03/04/2017",
    #       amount: 8.0,
    #       debit: false,
    #       money_transaction: true,
    #       bank_communication: false,
    #       communication: "B12ADEB34FC5DFC",
    #       movement_type: "vpn"
    #     }
    #   end

    #   it_behaves_like "a parsed movement row"
    # end

    # # TODO
    # describe "domain name member" do
    # end
  end
end
