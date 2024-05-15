# # Configure Spree Preferences
# #
# # Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
# #       If you would like users to be able to update a setting with the Admin it should NOT be set here.
# #
# # Note: If a preference is set here it will be stored within the cache & database upon initialization.
# #       Just removing an entry from this initializer will not make the preference value go away.
# #       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
# #
# # In order to initialize a setting do:
# # config.setting_name = 'new value'
Rails.application.config.after_initialize do
  # Add a new 'subscriptions' section to the Spree admin main menu
  Rails.application.config.spree_backend.main_menu.add(
    Spree::Admin::MainMenu::SectionBuilder.new("reviews", 'stars.svg').with_admin_ability_check(Spree::Review).with_items([
        Spree::Admin::MainMenu::ItemBuilder.new('spree_reviews.config_name', Spree::Core::Engine.routes.url_helpers.admin_reviews_path).with_match_path('/reviews').build,
        Spree::Admin::MainMenu::ItemBuilder.new('spree_reviews.review_settings', Spree::Core::Engine.routes.url_helpers.edit_admin_review_settings_path).with_match_path('/review_settings').build
      ])
      .build
  )
end

Spree.user_class = 'Spree::User'