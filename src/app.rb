#Setup environment
require 'pry'
require 'bundler/setup'
require 'dotenv'
Dotenv.load

#Require Dependencies
require "sinatra/base"
require "sinatra/activerecord"
require "sinatra/flash"
require "will_paginate"
require 'will_paginate/active_record'
require "will_paginate-bootstrap"
require "fog"
require "fog/aws"
require "carrierwave"
require "carrierwave/orm/activerecord"
require "carrierwave/storage/fog"

#Require Helpers
Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each {|file| require file }

#Require Models
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

#Require Routes
Dir[File.dirname(__FILE__) + '/routes/*.rb'].each {|file| require file }

class MyApplication < Sinatra::Base

  #Configure Sinatra
  set :root,      File.dirname(__FILE__)
  set :sessions,  true
  set :session_secret, "MY SECRET"

  register Sinatra::Flash
  register WillPaginate::Sinatra

  #Configure Development
  configure :development do


    #Save uploads locally for development
    CarrierWave.configure do |config|
      config.storage = :file
      config.root = File.dirname(__FILE__) + "/public"
    end

  end

  #Configure Production
  configure :production do

    #Uploads files to S3 for production
    CarrierWave.configure do |config|
      config.storage = :fog
      config.fog_credentials = {
        :provider              => 'AWS',
        :aws_access_key_id     => ENV['AWS_KEY'],
        :aws_secret_access_key => ENV['AWS_SECRET'],
        :region                => 'us-east-1'
      }
      config.cache_dir      = File.dirname(__FILE__) + "/tmp"
      config.fog_directory  = ENV['AWS_BUCKET_NAME']
      config.fog_public     = true
      config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" }
      config.storage        = :fog
    end

  end

end
