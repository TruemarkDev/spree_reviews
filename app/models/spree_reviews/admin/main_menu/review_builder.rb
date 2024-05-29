module SpreeReviews
  module Admin
    module MainMenu
      class ReviewBuilder
        include ::Spree::Core::Engine.routes.url_helpers

        def build
          items = [ 
                    Spree::Admin::MainMenu::ItemBuilder.new('spree_reviews.config_name', admin_reviews_path).
                      with_availability_check(->(ability, _store) { ability.can?(:manage, ::Spree::Review) && ability.can?(:index, ::Spree::Review) }).
                      with_match_path('/reviews').
                      build,
                    Spree::Admin::MainMenu::ItemBuilder.new('spree_reviews.review_settings', edit_admin_review_settings_path).
                      with_availability_check(->(ability, _store) { ability.can?(:manage, ::Spree::ProductQuestionSetting) }).
                      with_match_path('/review_settings').
                      build
                  ]

          Spree::Admin::MainMenu::SectionBuilder.new('reviews', 'stars.svg').
          with_items(items).
          build
        end
      end
    end
  end
end