module Spree
  module Api
    module V2
      module Storefront
        module Account
          class UserReviewsController < ::Spree::Api::V2::ResourceController
            before_action :require_spree_current_user

            # GET /api/v2/storefront/account/reviews
            def index
              render_serialized_payload { serialize_collection(paginated_collection) }
            end

            private

            def resource
              resource_finder.filter_reviews(reviews, params).most_recent_first
            end

            def reviews
              resource_finder.user_reviews(spree_current_user.id)
            end

            def collection_serializer
              Spree::V2::Storefront::ReviewSerializer
            end

            def paginated_collection
              collection_paginator.new(resource, params).call
            end

            def resource_finder
              Spree::Review
            end
          end
        end
      end
    end
  end
end
