require "rails_helper"

RSpec.describe CustomerSurchargeController, type: :controller do
  describe "POST #calculate with tax-inclusive pricing" do
    it "handles tax-inclusive products correctly" do
      seller = create(:user)
      product = create(:link, user: seller, tax_inclusive: true, price_cents: 1190)

      post :calculate, params: {
        items: [
          { permalink: product.unique_permalink, price_cents: 1190, quantity: 1 }
        ]
      }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)

      # Tax should be included in the price, not added separately
      expect(json_response["tax_included_cents"]).to eq(190)  # 19% of 1190
      expect(json_response["subtotal_cents"]).to eq(1000)     # Net price without tax
    end

    it "handles tax-exclusive products correctly" do
      seller = create(:user)
      product = create(:link, user: seller, tax_inclusive: false, price_cents: 1000)

      post :calculate, params: {
        items: [
          { permalink: product.unique_permalink, price_cents: 1000, quantity: 1 }
        ]
      }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)

      # Tax should be added on top of the price
      expect(json_response["tax_cents"]).to eq(190)           # 19% of 1000
      expect(json_response["subtotal_cents"]).to eq(1000)     # Base price
    end

    it "handles mixed tax-inclusive and tax-exclusive products" do
      seller = create(:user)
      tax_inclusive_product = create(:link, user: seller, tax_inclusive: true, price_cents: 1190)
      tax_exclusive_product = create(:link, user: seller, tax_inclusive: false, price_cents: 1000)

      post :calculate, params: {
        items: [
          { permalink: tax_inclusive_product.unique_permalink, price_cents: 1190, quantity: 1 },
          { permalink: tax_exclusive_product.unique_permalink, price_cents: 1000, quantity: 1 }
        ]
      }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)

      # Both tax types should be handled correctly
      expect(json_response["tax_included_cents"]).to eq(190)  # From tax-inclusive product
      expect(json_response["tax_cents"]).to eq(190)           # From tax-exclusive product
      expect(json_response["subtotal_cents"]).to eq(2000)     # 1000 + 1000 net prices
    end
  end
end
