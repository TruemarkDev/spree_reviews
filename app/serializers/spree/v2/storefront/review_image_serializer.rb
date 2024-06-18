module Spree
  module V2
    module Storefront
      class ReviewImageSerializer < BaseSerializer
        set_type :images

        attributes :styles
      end
    end
  end
end