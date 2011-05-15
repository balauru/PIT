require 'spec_helper'
require 'rspec/mocks'

describe PitsController do
  describe "POST with email that already exists" do
    it "should not insert a new user" do
      Factory(:user)
      lambda do
        post :report, :latitude => 1, :longitude => 2, :email => "test@test.com"
      end.should change(User, :count).by(0)
    end
  end

  describe "POST with email that doesn't exist" do
    it "should insert a new user" do
      lambda do
        post :report, :latitude => 1, :longitude => 2, :email => "test@test.com"
      end.should change(User, :count).by(1)
    end
  end

  describe "POST with all params" do
    it "should add pit to a user" do
      Factory(:user)
      post :report, :latitude => 1, :longitude => 2, :email => "test@test.com"
      assert_equal(Pit.first.user_id, User.first.id)
    end
  end

  describe "POST without longitude" do
    it "should not insert a new pit" do
      lambda do
        post :report, :latitude => 1, :email => "asdf"
      end.should change(Pit, :count).by(0)
    end
  end

  describe "POST without latitude" do
    it "should not insert a new pit" do
      lambda do
        post :report, :longitude => 2, :email => "asdf"
      end.should change(Pit, :count).by(0)
    end
  end

  describe "POST without email" do
    it "should not insert a new pit" do
      lambda do
        post :report, :latitude => 1, :longitude => 2
      end.should change(Pit, :count).by(0)
    end
  end
end

