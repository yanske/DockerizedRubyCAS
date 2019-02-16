module CASServer; end

require 'active_record'
require 'active_support'
require 'sinatra/base'
require 'builder' # for XML views
require 'logger'
$LOG = Logger.new(STDOUT)

# Out-dated active_record defaults table's primary key to NULL -> MYSQL2 doesn't like that :)
require 'active_record/connection_adapters/mysql2_adapter'
class ActiveRecord::ConnectionAdapters::Mysql2Adapter
  NATIVE_DATABASE_TYPES[:primary_key] = "int(11) auto_increment PRIMARY KEY"
end

require 'casserver/authenticators/base'
CASServer::Authenticators.autoload :LDAP, 'casserver/authenticators/ldap.rb'
CASServer::Authenticators.autoload :ActiveDirectoryLDAP, 'casserver/authenticators/active_directory_ldap.rb'
CASServer::Authenticators.autoload :SQL, 'casserver/authenticators/sql.rb'
CASServer::Authenticators.autoload :Google, 'casserver/authenticators/google.rb'
CASServer::Authenticators.autoload :SQLEncrypted, 'casserver/authenticators/sql_encrypted.rb'
CASServer::Authenticators.autoload :ActiveResource, 'casserver/authenticators/active_resource.rb'

require 'casserver/server'