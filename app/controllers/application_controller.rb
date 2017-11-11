class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_tags
  before_action :configure_permitted_parameters, if: :devise_controller?

  def authenticate_user_store_access
    unless Association.exists?(store_id: @store.id, user_id: current_user.id)
      flash[:notice] = "When you're a spy..."
      redirect_to stores_path
    end
  end

  def set_organization
    @organization = current_user.organizations.find(@store.organization_id)
  end

  def set_tags
    set_meta_tags(
      site: 'OrdrHub',
      description: 'Consolidate your orders from the most popular food delivery and ordering services into a single hub using OrdrHub!',
      keywords: 'ordrhub, orders, food, delivery, hub, consolidation, POS',
      canonical: 'https://www.ordrhub.com',
      image_src: 'https://www.ordrhub.com/assets/ipad-730366a2971461aaed23777fd71fb46be007147a005965fca772f09d8381ac16.png',
      'theme-color': '#ffffff',
      og: {
        title: 'OrdrHub',
        description: 'Consolidate your orders from the most popular food delivery and ordering services into a single hub using OrdrHub! Efficiently manage all of your online orders and integrate with your POS software.',
        image: 'https://www.ordrhub.com/assets/ipad-730366a2971461aaed23777fd71fb46be007147a005965fca772f09d8381ac16.png',
        url: 'https://www.ordrhub.com',
        type: 'website'
      },
      twitter: {
        card: 'website',
        site: '@OrdrHub',
        creator: '@OrdrHub',
        title: 'OrdrHub',
        description: 'Consolidate your orders from the most popular food delivery and ordering services into a single hub using OrdrHub! Efficiently manage all of your online orders and integrate with your POS software.',
        image: 'https://www.ordrhub.com/assets/ipad-730366a2971461aaed23777fd71fb46be007147a005965fca772f09d8381ac16.png',
      }
    )

    set_meta_tags icon: [
      { href: '/favicon-32x32.png', rel: 'icon', sizes: '32x32', type: 'image/png' },
      { href: '/favicon-16x16.png', rel: 'icon', sizes: '16x16', type: 'image/png' },
      { href: '/apple-touch-icon.png', rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      { href: '/manifest.json', rel: 'manifest', type: nil },
      { href: '/safari-pinned-tab.svg', rel: 'mask-icon', color: '#5bbad5', type: nil }
    ]
  end

  def store_belongs_to_organization?
    @store.try(:organization_id?)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
end
