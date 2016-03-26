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

  get '/robots/:id' do |id|
    @robot = robots.find(id)
    erb :show
  end

  get '/robots/:id/edit' do |id|
    @robot = robots.find(id)
    erb :edit
  end

  post '/robots' do
    robots.create(params[:robot])
    redirect '/robots'
  end

  put '/robots/:id' do |id|
    robots.update(id, params[:robot])
    redirect '/robots/'+id
  end

  delete '/robots/:id' do |id|
    robots.destroy(id)
    redirect '/robots'
  end

  def robots
    if ENV["RACK_ENV"] == "test"
      database = Sequel.sqlite('db/robots_test.sqlite')
    else
      database = Sequel.sqlite('db/robots_development.sqlite')
    end
    @robots ||= Robots.new(database)
  end
end
