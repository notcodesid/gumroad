require "rails_helper"

RSpec.describe SalesTaxCalculator do
  describe "#calculate with tax-inclusive pricing" do
    it "calculates tax correctly for tax-inclusive products" do
      product = build(:link, tax_inclusive: true)
      calculation = SalesTaxCalculator.new(
        product: product,
        price_cents: 1190,  # $11.90 including tax
        tax_rate: 0.19      # 19% tax rate
      ).calculate

      # Tax = price * (rate / (1 + rate))
      # Tax = 1190 * (0.19 / 1.19) = 190 cents
      expect(calculation.tax_amount_cents).to eq(190)
      expect(calculation.price_cents).to eq(1190)
      expect(calculation.net_price_cents).to eq(1000)  # $10.00 before tax
    end

    it "calculates tax correctly for tax-exclusive products" do
      product = build(:link, tax_inclusive: false)
      calculation = SalesTaxCalculator.new(
        product: product,
        price_cents: 1000,  # $10.00 before tax
        tax_rate: 0.19      # 19% tax rate
      ).calculate

      # Tax = price * rate
      # Tax = 1000 * 0.19 = 190 cents
      expect(calculation.tax_amount_cents).to eq(190)
      expect(calculation.price_cents).to eq(1000)
      expect(calculation.net_price_cents).to eq(1000)
    end

    it "handles Swedish tax rate for tax-inclusive products" do
      product = build(:link, tax_inclusive: true)
      calculation = SalesTaxCalculator.new(
        product: product,
        price_cents: 1250,  # $12.50 including tax
        tax_rate: 0.25      # 25% Swedish tax rate
      ).calculate

      # Tax = price * (rate / (1 + rate))
      # Tax = 1250 * (0.25 / 1.25) = 250 cents
      expect(calculation.tax_amount_cents).to eq(250)
      expect(calculation.price_cents).to eq(1250)
      expect(calculation.net_price_cents).to eq(1000)  # $10.00 before tax
    end
  end
end
