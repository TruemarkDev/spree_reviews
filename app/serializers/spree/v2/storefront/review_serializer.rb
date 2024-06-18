module Spree
  module V2
    module Storefront
      class ReviewSerializer < BaseSerializer
        set_type :review

        attributes :title, :review, :rating, :name, :show_identifier, :approved, :created_at

        has_many :images, serializer: :review_image
        has_one :user
        has_one :product
      end
    end
  end
end
