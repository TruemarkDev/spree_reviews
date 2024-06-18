require 'spec_helper'

describe Spree::Api::V2::Storefront::ReviewsController, type: :request do
  let!(:user) { create(:user) }
  let!(:product) { create(:product) }
  let!(:unapproved_review) { create(:review, product: product, user: user) }
  let!(:approved_review) { create(:review, product: product, approved: true) }

  before do
    allow_any_instance_of(described_class).to receive(:spree_current_user).and_return(user)
    allow_any_instance_of(described_class).to receive(:require_spree_current_user).and_return(user)
  end

  describe '#index' do
    it 'shows only approved reviews associated with a product for an anonymous user' do
      allow_any_instance_of(described_class).to receive(:spree_current_user).and_return(nil)
      get "/api/v2/storefront/products/#{product.id}/reviews"
      json_response = JSON.parse(response.body)

      expect(json_response['data']).to be_an(Array)
      review_ids = json_response['data'].map { |review| review['id'].to_i }

      expect(review_ids).to include(approved_review.id)
      expect(review_ids).not_to include(unapproved_review.id)
    end

    it 'shows approved and pending reviews by self for an authorized user' do
      get "/api/v2/storefront/products/#{product.id}/reviews"
      json_response = JSON.parse(response.body)

      expect(json_response['data']).to be_an(Array)
      review_ids = json_response['data'].map { |review| review['id'].to_i }

      expect(review_ids).to include(approved_review.id, unapproved_review.id)
    end
  end

  describe '#create' do
    let(:review_params) do
      {
        review: {
          name: 'Test Name',
          review: 'Nice Product',
          rating: '4'
        }
      }
    end

    it 'creates a new review' do
      post "/api/v2/storefront/products/#{product.id}/reviews", params: review_params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)

      expect(json_response['data']).to have_attribute(:review).with_value('Nice Product')
    end
  end

  describe '#update' do
    let(:review_params) do
      {
        review: {
          review: 'review updated!'
        }
      }
    end

    it 'updates a review' do
      put "/api/v2/storefront/products/#{product.id}/reviews/#{unapproved_review.id}", params: review_params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)

      expect(json_response['data']).to have_attribute(:review).with_value('review updated!')
    end
  end

  describe '#destroy' do
    it 'deletes a review' do
      delete "/api/v2/storefront/products/#{product.id}/reviews/#{unapproved_review.id}"

      expect(response).to have_http_status(:ok)
    end
  end
end
