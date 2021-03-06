require 'factory_bot_rails'

FactoryBot.definition_file_paths << 'spec/dummy/spec/factories'
FactoryBot.factories.clear
FactoryBot.find_definitions

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
