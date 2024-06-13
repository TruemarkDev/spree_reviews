module Spree
  module V2
    module Storefront
      class FeedbackReviewSerializer < BaseSerializer
        set_type :feedback_review

        attributes :id, :review_id, :user_id, :rating, :comment, :created_at

        belongs_to :user
        belongs_to :review
      end
    end
  end
end
