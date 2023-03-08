class Movement < ApplicationRecord
  ALLOWED_TYPES = {
    "banking_fee" =>  "Frais bancaires",
    "interests" =>  "Intérêts",
    "bank_communication" =>  "Communication bancaire",
    "hardware_order" =>  "Commande de briques",
    "domain_name" =>  "Réservation de nom de domaine",
    "hosting" =>  "Frais d'hébergement",
    "moniteur" =>  "Frais Moniteur",
    "network" =>  "Frais réseau",
    "hardware_order_member" =>  "Achat de brique",
    "vpn" =>  "Cotisation VPN",
    "domain_name_member" =>  "Achat de nom de domaine",
    "donation" => "Don",
    "chez_meme" => "Chez Mémé",
    "ibpt_membership" => "Cotisation IBPT",
    "hardware_purchase" => "Achat de matériel",
    "general_assembly_costs" => "Frais Assemblée Générale"
    "unknown" =>  "Inconnu",
    "custom" => "Custom Label"
  }

  validates_uniqueness_of :number, scope: :date
  validates_presence_of :number, :date, :amount, :movement_type, :raw
  validates_inclusion_of :movement_type, in: ALLOWED_TYPES.keys
  scope :unknown, -> { where(movement_type: "unknown") }
  scope :for_year, ->(year) { where("extract(year from date) = ?", year) }
  scope :before_year, ->(year) { where("extract(year from date) < ?", year) }
  scope :for_movement_type, ->(movement_type) do
    return all unless movement_type
    where(movement_type: movement_type)
  end

  def self.movement_type_options
    ALLOWED_TYPES.map { |k, v| [v, k] }
  end

  def self.from_row(movement_row)
    create(
      number: movement_row.number,
      date: movement_row.date,
      amount: movement_row.amount,
      iban: movement_row.iban,
      communication: movement_row.communication,
      movement_type: movement_row.movement_type,
      raw: movement_row.row
    )
  end

  def self.existing_years
    pluck(Arel.sql("distinct(extract(year from date))")).sort { |a, b| b <=> a }
                                                        .map(&:to_i)
  end

  def label
    return custom_label if movement_type == "custom" 

    ALLOWED_TYPES[movement_type]
  end
end
