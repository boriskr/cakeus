require 'spec_helper'

describe StuddyController do

  describe "GET 'program'" do
    it "returns http success" do
      get 'program'
      response.should be_success
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'invite'" do
    it "returns http success" do
      get 'invite'
      response.should be_success
    end
  end

end
