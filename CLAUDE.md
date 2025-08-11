# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Application Overview

Pairpen is a Rails 8.0.2 application using PostgreSQL as the database. The app follows standard Rails conventions with modern Rails features like:
- Hotwire (Turbo/Stimulus) for interactivity
- Importmap for JavaScript management
- Solid Cache, Solid Queue, and Solid Cable for caching, background jobs, and WebSockets
- PWA capabilities with service worker and manifest

## Development Commands

### Setup and Database
```bash
bundle install                    # Install Ruby dependencies
bundle exec rake db:create       # Create databases
bundle exec rake db:migrate      # Run migrations
bundle exec rake db:seed         # Load seed data
bundle exec rake db:setup        # Create, load schema, and seed (first time setup)
bundle exec rake db:reset        # Drop, create, load schema, and seed
```

### Testing
```bash
bundle exec rspec                 # Run all RSpec tests
bundle exec rspec spec/models/    # Run model tests only
bundle exec rspec spec/controllers/ # Run controller tests only
bundle exec rspec --tag focus     # Run tests tagged with :focus
```

### Code Quality and Linting
```bash
bundle exec rubocop              # Run Ruby linter (uses omakase config)
bundle exec rubocop -a           # Auto-correct safe offenses
bundle exec brakeman             # Run security analysis
```

### Server and Development
```bash
bin/rails server                 # Start development server
bin/rails console               # Rails console
bin/rails dbconsole            # Database console
```

### Assets and Cache
```bash
bundle exec rake assets:precompile # Compile assets
bundle exec rake assets:clobber    # Remove compiled assets
bundle exec rake tmp:clear         # Clear tmp files and cache
```

## Architecture and Structure

### Database Configuration
- Uses PostgreSQL with multiple database setup for production:
  - Primary database: `pairpen_production`
  - Cache database: `pairpen_production_cache` 
  - Queue database: `pairpen_production_queue`
  - Cable database: `pairpen_production_cable`
- Development uses single database: `pairpen_development`
- Test database: `pairpen_test`

### Modern Rails Stack
- **Background Jobs**: Solid Queue (runs in Puma process via `SOLID_QUEUE_IN_PUMA=true`)
- **Caching**: Solid Cache with database backend
- **WebSockets**: Solid Cable for ActionCable
- **JavaScript**: Importmap with Stimulus controllers
- **CSS**: Standard Rails asset pipeline with Propshaft
- **Browser Support**: Modern browsers only (webp, web push, CSS nesting, etc.)

### Deployment
- Configured for Kamal deployment with Docker
- Uses Thruster for HTTP acceleration
- SSL enabled with Let's Encrypt
- Persistent storage volume for Active Storage files

### Code Style and Testing
- Uses RuboCop with `rubocop-rails-omakase` configuration
- RSpec for testing with Rails integration
- Brakeman for security scanning
- Supports RSpec, RSpec Rails, and RSpec controllers extensions

## Key File Locations
- Main application class: `config/application.rb` (module: `Pairpen`)
- Routes: `config/routes.rb` (currently minimal with health check)
- Database config: `config/database.yml`
- Deployment config: `config/deploy.yml` (Kamal)
- Test setup: `spec/rails_helper.rb` and `spec/spec_helper.rb`

## Application Module
The Rails application is namespaced under the `Pairpen` module, defined in `config/application.rb`.