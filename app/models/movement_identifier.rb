# Identify the type of a MovementRow
class MovementIdentifier
  attr_reader :movement_row

  VPS_REGEX = /vps|chez meme|chez mémé/i
  ORDER_REGEX = /commande|composant|composants|order|brique|cube|cable|câble|carte sd|batterie|sata/i
  VPN_REGEX = /cotisation|abonnement|redevance|vpn|contribution|adhesion/i
  DONATION_REGEX = /don|donation|participation|soutien/i
  DOMAIN_REGEX = /renouvellement|domain|domaine/i
  NEUTRINET_ACCOUNT_NUMBER = "652-8349784-09"

  def self.type_for(movement_row)
    new(movement_row).run
  end

  def initialize(movement_row)
    @movement_row = movement_row
  end

  def run
    return "banking_fee" if banking_fee? 
    return "interests" if interests?
    return "bank_communication" if bank_communication?
    return "hardware_order" if olimex?
    return "domain_name" if gandi?
    return "hosting" if verixi? || ovh? || hetzner? || tetaneutral?
    return "moniteur" if moniteur?
    return "network" if gitoyen?
    return "membership_ibpt" if membership_ibpt?
    return "hardware_order_member" if order?
    return "chez_meme" if vps?
    return "donation" if donation?
    return "vpn" if vpn?
    return "domain_name_member" if domain?

    "unknown"
  end

  private

  def no_third_party_iban?
    movement_row.iban.nil? || movement_row.iban == NEUTRINET_ACCOUNT_NUMBER
  end

  def banking_fee?
    return false unless movement_row.debit?
    no_third_party_iban? || movement_row.communication&.include?("Décompte de frais")
  end

  def interests?
    return false if movement_row.communication&.start_with?("Virement en votre faveur")
    return false if movement_row.communication =~ VPN_REGEX
    no_third_party_iban? && movement_row.credit?
  end

  def bank_communication?
    movement_row.bank_communication?
  end

  def olimex?
    %w(BG89FINV91501016150445
       BG23PRCB92301450517901
       GB24MIDL40051570524370).include?(movement_row.iban)
  end

  def gandi?
    %w(LU960030878793070000).include?(movement_row.iban)
  end

  def ovh?
    %w(FR7630056005030503000004147).include?(movement_row.iban)
  end

  def hetzner?
    %w(DE92760700120750007700).include?(movement_row.iban)
  end

  def verixi?
    %w(BE03068889146584).include?(movement_row.iban)
  end

  def tetaneutral?
    %w(FR7642559100000801284747270).include?(movement_row.iban)
  end

  def moniteur?
    %w(BE48679200550227).include?(movement_row.iban) 
  end

  def gitoyen?
    %w(FR7610278060310002045230163).include?(movement_row.iban)
  end

  def membership_ibpt?
    %w(BE75679122690751).include?(movement_row.iban)
  end

  def order?
    return if vpn?

    movement_row.communication =~ ORDER_REGEX
  end

  def vps?
    return if vpn?

    movement_row.communication =~ VPS_REGEX
  end

  def donation?
    return if vpn?

    movement_row.credit? && movement_row.communication =~ DONATION_REGEX
  end

  def vpn?
    return true if movement_row.credit? && movement_row.communication =~ VPN_REGEX
    return false if movement_row.debit? || movement_row.communication =~ ORDER_REGEX

    movement_row.communication.nil? || movement_row.amount.between?(0.1, 12)
  end

  def domain?
    return unless movement_row.amount.between?(6, 35)
    movement_row.communication =~ DOMAIN_REGEX
  end
end
