Rails.application.routes.draw do
  mount EnumTimestamps::Engine => "/enum_timestamps"
end
