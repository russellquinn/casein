require "casein"
require "rails"
require 'bootstrap-sass'

module Casein
  class Engine < Rails::Engine
    
    config.after_initialize do
      Rails.application.config.assets.paths << root.join("app", "assets", "fonts")
    end

    initializer "casein.assets.precompile" do |app|
      app.config.assets.precompile += %w(casein/*.svg casein/*.eot casein/*.woff casein/*.ttf casein/login.css casein/casein.css casein/casein.js casein/html5shiv.js casein/custom.css casein/custom.js casein/*.png)
    end

    rake_tasks do
      load "railties/tasks.rake"
    end
    
  end
  
  class RouteConstraint

     def matches?(request)
       return false if request.fullpath.include?("/casein")
       return false if request.fullpath.include?("/admin")
       true
     end

   end
end
