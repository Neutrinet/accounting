require "rails_helper"

RSpec.describe Report do
  let(:year) { 2018 }
  let(:previous_year) { year - 1 }
  let(:next_year) { year + 1 }
  let(:report) { Report.new(year) }

  before do
    new_movement(date: "#{next_year}-01-01", amount: 20.0).save
    new_movement(date: "#{next_year}-06-01", amount: -5.0).save
    new_movement(date: "#{next_year}-12-31", amount: 10.0).save
  end

  context "when there is no movements in previous year" do
    it "has a previous balance" do
      expect(report.previous_balance).to eql(0.0)
    end

    context "when there are no movement for the year" do
      it "has a current balance" do
        expect(report.current_balance).to eql(0.0)
      end

      it "has an empty list of movements" do
        expect(report.movements).to be_empty
      end
    end

    context "when there are movements for the year" do
      before do
        new_movement(date: "#{year}-01-01", amount: 100.0).save
        new_movement(date: "#{year}-06-01", amount: -50.0).save
        new_movement(date: "#{year}-12-31", amount: 20.0).save
      end

      it "has a current blance" do
        expect(report.current_balance).to eql(70.0)
      end

      it "has a list of movements" do
        expect(report.movements.count).to eql(3)
      end
    end
  end

  context "when there are movements in the previous year" do
    before do
      new_movement(date: "#{previous_year}-01-01", amount: 18.0).save
      new_movement(date: "#{previous_year}-06-01", amount: -5.0).save
      new_movement(date: "#{previous_year}-12-31", amount: 2.0).save
    end

    it "has a previous balance" do
      expect(report.previous_balance).to eql(15.0)
    end

    context "when there are no movement for the year" do
      it "has a current balance" do
        expect(report.current_balance).to eql(15.0)
      end

      it "has an empty list of movements" do
        expect(report.movements).to be_empty
      end
    end

    context "when there are movements for the year" do
      before do
        new_movement(date: "#{year}-01-01", amount: 100.0).save
        new_movement(date: "#{year}-06-01", amount: -50.0).save
        new_movement(date: "#{year}-12-31", amount: 20.0).save
      end

      it "has a current blance" do
        expect(report.current_balance).to eql(85.0)
      end

      it "has a list of movements" do
        expect(report.movements.count).to eql(3)
      end
    end
  end
end
