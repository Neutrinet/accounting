require "csv"

class MovementIdentifier
  attr_reader :movement

  def self.type_for(movement)
    new(movement).run
  end

  def initialize(movement)
    @movement = movement
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
    return "hardware_order" if order?
    return "vpn" if vpn?
    return "domain_name" if domain?

    "unknown"
  end

  private

  def banking_fee?
    !movement.iban && movement.debit?
  end

  def interests?
    !movement.iban && movement.credit?
  end

  def bank_communication?
    movement.bank_communication?
  end

  def olimex?
    %w(BG23PRCB92301450517901 GB24MIDL40051570524370).include?(movement.iban)
  end

  def gandi?
    %w(LU960030878793070000).include?(movement.iban)
  end

  def i3d?
    %w(NL51INGB0004490008).include?(movement.iban)
  end

  def moniteur?
    %w(BE48679200550227).include?(movement.iban) 
  end

  def gitoyen?
    %w(FR76 1027 8060 3100 0204 5230 163).include?(movement.iban)
  end

  def order?
    return if vpn?

    movement.communication =~ /commande|order|brique|cube|cable|câble|carte sd/i
  end

  def vpn?
    movement.communication =~ /cotisation|abonnement|redevance|vpn/i ||
      movement.communication.nil? ||
      movement.amount.between?(0.1, 12)
  end

  def domain?
    return unless movement.amount.between?(6, 35)
    movement.communication =~ /renouvellement|domain|domaine/i
  end
end

class MovementRow
  attr_reader :row

  def initialize(row)
    @row = row
  end

  def account
    row["Rekening tegenpartij"] 
  end

  def number
    row["Omzetnummer"] 
  end

  def date
    row["Boekingsdatum"] 
  end

  def amount
    @amount ||= row["Bedrag"]&.gsub(",", ".").to_f
  end

  def debit?
    amount < 0
  end

  def credit?
    amount > 0 
  end

  def bank_communication?
    amount == 0.0 && bank_communication 
  end

  def iban
    return unless details

    @iban ||= begin
      matches = /(IBAN\:\s)(?<iban>[[:alnum:]]+)(\s)/.match(details) ||
                /(Compte [[:alpha:]\s']*: )(?<iban>.+)(\sCode)/.match(details)
      return unless matches

      matches["iban"].gsub(" ", "")
    end
  end

  def communication
    return unless details

    @communication ||= begin
      matches = /(Communication : )(?<communication>.+)\Z/.match(details)
      return unless matches

      matches["communication"].strip
    end
  end

  # big-ass field that contains most of the needed info such as IBAN,
  # communication, name, ... But of course, in an instructured way ...
  def details
    @details ||= row["Detail van de omzet"]&.gsub(/(\s)+/, " ")&.encode("utf-8")
  end

  # used by the bank for rows that are not money transaction but informational
  # messages like "a new card has been sent..."
  def bank_communication
    row["Bericht"]
  end

  def inspect
    "Movement N°#{number} from #{date} - #{iban} - #{amount} - #{communication}"
  end

  def to_s
    inspect
  end

  def movement_type
    @movement_type ||= MovementIdentifier.type_for(self)
  end
end

unknowns = []
CSV.foreach("../ing.csv", encoding: "ISO-8859-1", col_sep: ";", headers: true) do |row|
  movement = MovementRow.new(row)
  next if movement.amount == 0.0

  if movement.movement_type == "unknown"
    unknowns << movement
    next
  end

  puts "#{movement.movement_type}: #{movement.date}-#{movement.number} €#{movement.amount} - #{movement.iban} - #{movement.communication}"
end

puts "Unknowns:"
unknowns.each do |movement|
  puts "#{movement.date}-#{movement.number} €#{movement.amount} - #{movement.iban} - #{movement.communication}"
end
