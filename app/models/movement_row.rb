# Map a row from the CSV file to easy to use properties
class MovementRow
  attr_reader :row

  def initialize(row)
    @row = row
  end

  # not used, it's the old non-iban account format, not always there
  # def account
  #   row["Rekening tegenpartij"] 
  # end

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

  def money_transaction?
    amount && amount != 0.0
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
