# Identify the type of a MovementRow
class MovementIdentifier
  attr_reader :movement_row

  ORDER_REGEX = /commande|composant|composants|order|brique|cube|cable|câble|carte sd/i
  VPN_REGEX = /cotisation|abonnement|redevance|vpn/i
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
    return "hosting" if i3d?
    return "moniteur" if moniteur?
    return "network" if gitoyen?
    return "hardware_order_member" if order?
    return "vpn" if vpn?
    return "domain_name_member" if domain?

    "unknown"
  end

  private

  def no_third_party_iban?
    movement_row.iban.nil? || movement_row.iban == NEUTRINET_ACCOUNT_NUMBER
  end

  def banking_fee?
    no_third_party_iban? && movement_row.debit?
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

  def i3d?
    %w(NL51INGB0004490008).include?(movement_row.iban)
  end

  def moniteur?
    %w(BE48679200550227).include?(movement_row.iban) 
  end

  def gitoyen?
    %w(FR7610278060310002045230163).include?(movement_row.iban)
  end

  def order?
    return if vpn?

    movement_row.communication =~ ORDER_REGEX
  end

  def vpn?
    return true if movement_row.communication =~ VPN_REGEX
    return false if movement_row.communication =~ ORDER_REGEX

    movement_row.communication.nil? || movement_row.amount.between?(0.1, 12)
  end

  def domain?
    return unless movement_row.amount.between?(6, 35)
    movement_row.communication =~ /renouvellement|domain|domaine/i
  end
end
