require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'models/user.rb'
require_relative 'models/peep.rb'

DataMapper.setup(:default, "postgres://localhost/chitter_#{ENV['RACK_ENV']}")
DataMapper.finalize
