module SpreeBaseFrontend
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __FILE__)
      class_option :auto_run_migrations, type: :boolean, default: false

      def add_javascripts
        append_file 'vendor/assets/javascripts/spree/frontend/all.js', "//= require spree/frontend/spree_base_frontend\n"
        append_file 'vendor/assets/javascripts/spree/backend/all.js', "//= require spree/backend/spree_base_frontend\n"
      end

      def add_webpack_config
        inject_into_file 'config/webpack/environment.js', "const spreeBaseFrontend = require('./spree_base_frontend')\nenvironment.config.merge(spreeBaseFrontend)\n", 
          before: "module.exports = environment"
        append_file 'app/javascript/packs/home.js', "import spree_base_frontend from '~spree_base_frontend/app/javascript/packs/home.js'\n"
        template 'spree_base_frontend.js', 'config/webpack/spree_base_frontend.js'
      end

      def add_stylesheets
        inject_into_file 'vendor/assets/stylesheets/spree/frontend/all.css', " *= require spree/frontend/spree_base_frontend\n", before: %r{\*\/}, verbose: true
        inject_into_file 'vendor/assets/stylesheets/spree/backend/all.css', " *= require spree/backend/spree_base_frontend\n", before: %r{\*\/}, verbose: true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_base_frontend'
      end

      def run_migrations
        run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask('Would you like to run the migrations now? [Y/n]'))
        if run_migrations
          run 'bundle exec rake db:migrate'
        else
          puts 'Skipping rake db:migrate, don\'t forget to run it!'
        end
      end
    end
  end
end
