# Map a row from the CSV file to easy to use properties
class MovementRow
  attr_reader :row

  def initialize(row)
    @row = row
  end

  def legacy_account
    row["Rekening tegenpartij"] || row["Compte partie adverse"]
  end

  def number
    row["Omzetnummer"] || row["Numéro de mouvement"]
  end

  def date
    row["Boekingsdatum"] || row["Date comptable"]
  end

  def amount
    @amount ||= begin
      column = row["Bedrag"] || row["Montant"]
      column&.gsub(",", ".").to_f
    end
  end

  def debit?
    amount < 0
  end

  def credit?
    amount > 0 
  end

  def money_transaction?
    amount && amount != 0.0
  end

  def bank_communication?
    amount == 0.0 && bank_communication 
  end

  def iban
    return unless details || label

    @iban ||= begin
      matches = /(IBAN\:\s)(?<iban>[[:alnum:]]+)(\s)/.match(details) ||
                /(Compte [[:alpha:]\s']*:\s?)(?<iban>.+)(\sCode)/.match(details) ||
                /(.*\:.*-\s)(?<iban>[[:alnum:]]+)(.*)/.match(label)
      return legacy_account unless matches

      matches["iban"].gsub(" ", "")
    end
  end

  def communication
    return unless details || label

    @communication ||= begin
      matches = /(Communication : )(?<communication>.+)\Z/.match(details) ||
        /(Communication: )(?<communication>.+)\Z/.match(label)
      return [details, label].compact.join(" / ") unless matches

      matches["communication"].strip
    end
  end

  # big-ass field that contains most of the needed info such as IBAN,
  # communication, name, ... But of course, in an instructured way ...
  def details
    @details ||= begin
      column = row["Detail van de omzet"] || row["Détails du mouvement"]
      column&.gsub(/(\s)+/, " ")&.encode("utf-8")&.strip
    end
  end

  # used by the bank for rows that are not money transaction but informational
  # messages like "a new card has been sent..."
  def bank_communication
    row["Bericht"] || row["Message"]
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

  private

  def label
    @label ||= begin
      column = row["Omschrijving"] || row["Libellés"]
      column&.gsub(/(\s)+/, " ")&.strip
    end
  end
end
