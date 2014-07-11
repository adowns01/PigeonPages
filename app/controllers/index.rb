get '/' do
 erb :index
end


get '/error' do
  erb :error
end

not_found do
  redirect to('/error')
end
