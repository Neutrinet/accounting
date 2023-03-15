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

    describe "vpn 2" do
      let(:fixture_name) { "vpn_2" }
      let(:expected_values) do
        {
          iban: "BE12123456781212",
          number: "349",
          date: "09/12/2016",
          amount: 12.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "Cotisation Foo",
          movement_type: "vpn"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "vpn no iban" do
      let(:fixture_name) { "vpn_no_iban" }
      let(:expected_values) do
        {
          iban: "123-1234567-12",
          number: "2",
          date: "16/09/2014",
          amount: 40.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "Virement en votre faveur + 40,00 Cotisation Neutrinet Jane (Doe) Mar",
          movement_type: "vpn"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "vpn virement en votre faveur" do
      let(:fixture_name) { "vpn_virement_en_votre_faveur" }
      let(:expected_values) do
        {
          iban: nil,
          number: "158",
          date: "22/09/2015",
          amount: 9.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "Virement en votre faveur + 9,00 COTISATION OF JANE DOE",
          movement_type: "vpn"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "vpn virement en votre faveur 2" do
      let(:fixture_name) { "vpn_virement_en_votre_faveur_2" }
      let(:expected_values) do
        {
          iban: nil,
          number: "48",
          date: "11/06/2015",
          amount: 10.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "Virement en votre faveur + 10,00 de John Doe",
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

    describe "vpn 1" do
      let(:fixture_name) { "vpn_1" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "191",
          date: "19/06/2018",
          amount: 8.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "Merckx VPN Info personnelle: 123456789",
          movement_type: "vpn"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "vpn 2" do
      let(:fixture_name) { "vpn_2" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "23",
          date: "03/01/2023",
          amount: 8.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "Cotisation Eddy Merckx Info personnelle: NOT PROVIDED",
          movement_type: "vpn"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "vpn 3" do
      let(:fixture_name) { "vpn_3" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "61",
          date: "01/02/2023",
          amount: 10.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "Eddy Merckx VPN DOMAIN MEMBERSHIP",
          movement_type: "vpn"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "vps" do
      let(:fixture_name) { "vps" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "57",
          date: "01/02/2023",
          amount: 150.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "VPS",
          movement_type: "chez_meme"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "domain name member" do
      let(:fixture_name) { "domain_name_member" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "290",
          date: "08/07/2022",
          amount: 21.3,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "pour le nom de domaine example.com",
          movement_type: "domain_name_member"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "hardware order member 1" do
      let(:fixture_name) { "hardware_order_member_1" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "257",
          date: "24/06/2022",
          amount: 20.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "materiel brique internet",
          movement_type: "hardware_order_member"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "hardware order member 2" do
      let(:fixture_name) { "hardware_order_member_2" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "446",
          date: "02/11/2022",
          amount: 53.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "order n42 of Eddy M. Info personnelle: NOT PROVIDED",
          movement_type: "hardware_order_member"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "donation 1" do
      let(:fixture_name) { "donation_1" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "520",
          date: "18/12/2022",
          amount: 50.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "donation",
          movement_type: "donation"
        }
      end

      it_behaves_like "a parsed movement row"
    end
  
    describe "donation 2" do
      let(:fixture_name) { "donation_2" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "10",
          date: "02/01/2023",
          amount: 15.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "Dons",
          movement_type: "donation"
        }
      end

      it_behaves_like "a parsed movement row"
    end
  
    describe "donation 3" do
      let(:fixture_name) { "donation_3" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "81",
          date: "10/02/2023",
          amount: 10.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "soutien",
          movement_type: "donation"
        }
      end

      it_behaves_like "a parsed movement row"
    end
  
    describe "donation 4" do
      let(:fixture_name) { "donation_4" }
      let(:expected_values) do
        {
          iban: "BE12123456781234",
          number: "411",
          date: "11/10/2022",
          amount: 60.0,
          debit: false,
          money_transaction: true,
          bank_communication: false,
          communication: "neutridon 2022",
          movement_type: "donation"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "olimex 1" do
      let(:fixture_name) { "olimex_1" }
      let(:expected_values) do
        {
          iban: "BG42UBBS78211413539319",
          number: "168",
          date: "05/05/2021",
          amount: -842.1,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "Invoice .W-XY012345",
          movement_type: "hardware_order"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "olimex 2" do
      let(:fixture_name) { "olimex_2" }
      let(:expected_values) do
        {
          iban: "BG42UBBS78211413539319",
          number: "254",
          date: "20/06/2022",
          amount: -972.61,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "Invoice W-XY012345",
          movement_type: "hardware_order"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "gandi 1" do
      let(:fixture_name) { "gandi_1" }
      let(:expected_values) do
        {
          iban: "LU960030878793070000",
          number: "248",
          date: "15/08/2018",
          amount: -100.0,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "Transaction Number : 37762224",
          movement_type: "domain_name"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "gandi 2" do
      let(:fixture_name) { "gandi_2" }
      let(:expected_values) do
        {
          iban: "FR7610107001180052505152341",
          number: "96",
          date: "24/02/2023",
          amount: -150.0,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "100908610",
          movement_type: "domain_name"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "banking fee" do
      let(:fixture_name) { "banking_fee" }
      let(:expected_values) do
        {
          iban: "BE45310915602789",
          number: "2",
          date: "02/01/2019",
          amount: -160.38,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "FACTURE n° 2018/01/001317788 du 31/12/2018 ING Belgique SA - Avenue Marnix 24, B-1000 Bruxelles TVA BE 0403.200.393 - BIC (SWIFT): BBRUBEBB - IBAN: BE45 3109 1560 2789 NEUTRINET ASBL RUE DE NIEUWENHOVE 31, B-1180 BRUXELLES TVA BE 0835.033.012 Décompte de frais au 31/12/2018 n° 90189126 Compte Entreprise ING Plus BE52 6528 3497 8409 EUR Compte à vue BE52 6528 3497 8409 EUR Opérations au-delà du forfait + 0,0000 EUR (1) Port et frais relatifs au compte - 1,6800 EUR (7) Période du 01/01/2019 au 31/12/2019 Frais de tenue de compte - 44,0000 EUR (7) Forfait annuel comprenant 12 opérations de débit manuelles, un nombre illimité d'opérations électroniques, l'accès à Self'Bank, Phone'Bank et Business'Bank, 2 mandataires pour la gestion du compte, et une carte de paiement ING avec le Service de paiement et de retrait en Belgique et en Europe - 70,0000 EUR (1) Carte de paiement ING 6703-9309-3500-3201 Période du 01/01/2019 au 31/12/2019 Cotisation annuelle pour le service de paiement et de retrait en Belgique et en Europe + 0,0000 EUR (1) Carte de paiement ING 6703-9309-3500-3202 Période du 01/01/2019 au 31/12/2019 Cotisation annuelle pour le service de paiement et de retrait en Belgique et en Europe - 8,2645 EUR (1) Carte de paiement ING 6703-9309-3500-3203 Période du 01/01/2019 au 31/12/2019 Cotisation annuelle pour le service de paiement et de retrait en Belgique et en Europe - 8,2645 EUR (1) Carte de paiement ING 6703-3032-6661-2701 Période du 01/01/2019 au 31/12/2019 Cotisation annuelle pour le service de paiement et de retrait en Belgique et en Europe - 8,2645 EUR (1) -------------------------------------------------- TVA 21 % sur : - 94,7935 (1) - 19,91 EUR Non soumis à la TVA : - 45,6800 (7) Exempté de TVA : art.44 par.3 7°, C. TVA BE Total au débit du compte BE52 6528 3497 8409 : - 160,38 EUR / Décompte de frais n° 90189126 Pièce justificative en annexe",
          movement_type: "banking_fee"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "verixi 1" do
      let(:fixture_name) { "verixi_1" }
      let(:expected_values) do
        {
          iban: "BE03068889146584",
          number: "24",
          date: "11/01/2021",
          amount: -42.00,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "202100175",
          movement_type: "hosting"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "verixi 2" do
      let(:fixture_name) { "verixi_2" }
      let(:expected_values) do
        {
          iban: "BE03068889146584",
          number: "458",
          date: "06/12/2021",
          amount: -42.00,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "202104673",
          movement_type: "hosting"
        }
      end

      it_behaves_like "a parsed movement row"
    end
  
    describe "hetzner" do
      let(:fixture_name) { "hetzner" }
      let(:expected_values) do
        {
          iban: "DE92760700120750007700",
          number: "475",
          date: "16/12/2021",
          amount: -100.00,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "Client number K1162318420",
          movement_type: "hosting"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "ovh" do
      let(:fixture_name) { "ovh" }
      let(:expected_values) do
        {
          iban: "FR7630056005030503000004147",
          number: "473",
          date: "21/11/2022",
          amount: -131.00,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "BC 181079150",
          movement_type: "hosting"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "tetaneutral" do
      let(:fixture_name) { "tetaneutral" }
      let(:expected_values) do
        {
          iban: "FR7642559100000801284747270",
          number: "337",
          date: "20/08/2022",
          amount: -80.00,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "Facture F20220726-0008-ADT1349",
          movement_type: "hosting"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "gitoyen" do
      let(:fixture_name) { "gitoyen" }
      let(:expected_values) do
        {
          iban: "FR7610278060310002045230163",
          number: "41",
          date: "15/01/2023",
          amount: -84.00,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "FA2301-1425",
          movement_type: "network"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "ibpt 1" do
      let(:fixture_name) { "ibpt_1" }
      let(:expected_values) do
        {
          iban: "BE75679122690751",
          number: "35",
          date: "17/01/2022",
          amount: -341.00,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "***202/1011/44047***",
          movement_type: "ibpt_membership"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "ibpt 2" do
      let(:fixture_name) { "ibpt_2" }
      let(:expected_values) do
        {
          iban: "BE66679199989243",
          number: "474",
          date: "21/11/2022",
          amount: -360.00,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "***100/0097/46211***",
          movement_type: "ibpt_membership"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "moniteur" do
      let(:fixture_name) { "moniteur" }
      let(:expected_values) do
        {
          iban: "BE48679200550227",
          number: "165",
          date: "19/04/2022",
          amount: -140.24,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "BE0835.033.012",
          movement_type: "moniteur"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    describe "donation to support organization" do
      let(:fixture_name) { "donation_support" }
      let(:expected_values) do
        {
          iban: "BE73001839135760",
          number: "251",
          date: "15/06/2022",
          amount: -50.0,
          debit: true,
          money_transaction: true,
          bank_communication: false,
          communication: "Don",
          movement_type: "unknown"
        }
      end

      it_behaves_like "a parsed movement row"
    end

    # -------------------------------------------------------------------------
    # begin example spec
    # describe "my new transaction" do
    #   let(:fixture_name) { "my_new_transaction" }
    #   let(:expected_values) do
    #     {
    #       iban: "NL51INGB0004490008",
    #       number: "243",
    #       date: "07/08/2018",
    #       amount: -173.03,
    #       debit: true,
    #       money_transaction: true,
    #       bank_communication: false,
    #       communication: "Client no.: K126687 invoice no.: F18-0100017375",
    #       movement_type: "hosting"
    #     }
    #   end

    #   it_behaves_like "a parsed movement row"
    # end
    # end example spec
    # -------------------------------------------------------------------------

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
