# Resets all preferences to default values, you can
# pass a block to override the defaults with a block
#
# reset_spree_preferences do |config|
#   config.site_name = "my fancy pants store"
# end
#
def reset_spree_preferences
  config = Spree::Config
  yield(config) if block_given?
end

