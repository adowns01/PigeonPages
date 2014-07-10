require 'spec_helper'

describe "User model" do
  it "it creates a user with valid params" do
    User.delete_all
    user_info = {
      name: "Amelia",
      email: "sample@example.com",
      password: "password"
    }
    user = User.create(user_info)
    expect(user.valid?).to eq(true)
  end

  it "doesn't create a user if name is not unique" do
    User.delete_all

    user_info1 = { name: "Amelia", email: "sample@example.com", password: "password"}
    user1 = User.create(user_info1)

    user2_info = {name: "Amelia", email: "ex@gmail.com", password: "password"}
    user2 = User.create(user2_info)

    expect(user2.valid?).to eq(false)
  end

  it "doesn't create a user if email is not unique" do
    User.delete_all

    user_info1 = { name: "Amelia", email: "sample@example.com", password: "password"}
    user1 = User.create(user_info1)

    user2_info = {name: "AmeliaD", email: "sample@example.com", password: "password"}
    user2 = User.create(user2_info)

    expect(user2.valid?).to eq(false)
  end


  it "doesn't create a user if a email is not in the right format" do
    User.delete_all

    user_info1 = { name: "Amelia", email: "hithere", password: "password"}
    user1 = User.create(user_info1)

    expect(user1.valid?).to eq(false)
  end

  it "doesn't create a user if params are blank" do
    user_info1 = {password: "password"}
    user1 = User.create(user_info1)

    expect(user1.valid?).to eq(false)
  end
end
