require 'models/robots'

class RobotWorld < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    erb :dashboard
  end

  get '/robots'do
    @robots = robots.all
    erb :index
  end

  get '/robots/new' do
    erb :new
  end

  get '/robots/:name' do |name|
    @robot = robots.find(name)
    erb :show
  end

  get '/robots/:name/edit' do |name|
    @robot = robots.find(name)
    erb :edit
  end

  post '/robots' do
    robots.create(params[:robot])
    redirect '/robots'
  end

  put '/robots/:name' do |name|
    robots.update(name, params[:robot])
    redirect '/robots/'+name
  end

  delete '/robots/:name' do |name|
    robots.delete(name)
    redirect '/robots'
  end

  def robots
    database = YAML::Store.new('db/robot_world')
    @robots ||= Robots.new(database)
  end
end
