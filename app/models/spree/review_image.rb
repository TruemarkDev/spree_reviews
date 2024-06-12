module Spree
  class ReviewImage < Asset
    include Spree::Image::Configuration::ActiveStorage
    include Rails.application.routes.url_helpers

    def styles
      self.class.styles.map do |_, size|
        width, height = size[/(\d+)x(\d+)/].split('x')

        {
          url: polymorphic_url(attachment.variant(resize: size), only_path: false),
          width: width,
          height: height
        }
      end
    end
  end
end