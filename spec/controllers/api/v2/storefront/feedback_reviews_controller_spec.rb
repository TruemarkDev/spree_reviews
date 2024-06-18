require 'spec_helper'

describe Spree::Api::V2::Storefront::FeedbackReviewsController, type: :request do
  let!(:user) { create(:user) }
  let!(:review) { create(:review) }
  let!(:feedback_review_1) { create(:feedback_review, user: user, review: review) }
  let!(:feedback_review_2) { create(:feedback_review, user: user, review: review) }

  before do
    allow_any_instance_of(described_class).to receive(:spree_current_user).and_return(user)
    allow_any_instance_of(described_class).to receive(:require_spree_current_user).and_return(user)
  end

  describe '#index' do
    it 'shows the feedback reviews associated with the review' do
      get "/api/v2/storefront/reviews/#{review.id}/feedback_reviews"
      json_response = JSON.parse(response.body)

      expect(json_response['data']).to be_an(Array)
      feedback_review_ids = json_response['data'].map { |feedback_review| feedback_review['id'].to_i }

      expect(feedback_review_ids).to include(feedback_review_1.id, feedback_review_2.id)
    end
  end

  describe '#create' do
    let(:feedback_review_params) do
      {
        feedback_review: {
          comment: 'feedback review',
          rating: '4'
        }
      }
    end

    it 'creates a new feedback_review' do
      post "/api/v2/storefront/reviews/#{review.id}/feedback_reviews", params: feedback_review_params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)

      expect(json_response['data']).to have_attribute(:comment).with_value('feedback review')
    end
  end

  describe '#update' do
    let(:feedback_review_params) do
      {
        feedback_review: {
          comment: 'feedback review updated!'
        }
      }
    end

    it 'updates a feedback_review' do
      put "/api/v2/storefront/reviews/#{review.id}/feedback_reviews/#{feedback_review_1.id}", params: feedback_review_params
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)

      expect(json_response['data']).to have_attribute(:comment).with_value('feedback review updated!')
    end
  end

  describe '#destroy' do
    it 'deletes a feedback_review' do
      delete "/api/v2/storefront/reviews/#{review.id}/feedback_reviews/#{feedback_review_1.id}"

      expect(response).to have_http_status(:ok)
    end
  end
end
