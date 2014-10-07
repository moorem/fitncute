# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|

  config.admin_interface_logo = 'admin/logo.png'
  config.logo = 'store/logo.png'
  config.allow_guest_checkout = false
  config.currency = 'INR'
  config.mails_from = 'admin@fitncute.com'
  country = Spree::Country.find_by_name('India') if Spree::Country.table_exists?
  config.default_country_id = country.id if country.present?
  config.max_level_in_taxons_menu = 0
  #config.site_name = 'Fit and Cute'
  #config.site_url = 'www.fitncute.com'
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
end

Spree.user_class = 'Spree::User'