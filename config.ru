require './config/environment'

if ActiveRecord::Base.connection.migration_context.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride

run ApplicationController
use SessionsController
use TeamsController
use PlayersController
use SeasonsController
use GamesController
use GoalsController
use PenaltiesController