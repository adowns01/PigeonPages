get '/sessions/new' do
  erb :sign_in
end



post '/sessions' do
  # sign-in
  login
  redirect to '/'
end



delete '/sessions/:id' do
  # sign-out -- invoked
  session.clear
  redirect to '/'
end