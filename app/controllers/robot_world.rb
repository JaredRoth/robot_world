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

  get '/robots/:name' do
    erb :show
  end

  get 'robots/new' do
    erb :new
  end

  get '/robots/:name/edit' do |name|
    erb :edit
  end

  post 'robots' do
    redirect '/robots'
  end

  put 'robots/:name' do |name|
    redirect '/robots'+name
  end

  delete 'robots/:name' do |name|
    redirect '/robots'
  end
end
