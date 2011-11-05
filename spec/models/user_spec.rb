require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
   context "Simple operations" do
     before do
       User.delete_all
       User.create!(email:"boris@iloveboris.com",provider:"twitter",uid:"12313123")
       user = User.create!(email:"boris@iloveboris.com",provider:"facebook",uid:"fgsdg3423")
       User.enable(user,"manager")
       User.enable(user,"informator")
     end
     let!(:user) do
        User.first
     end
      it "asserting role" do
          User.all.each do |user|
            (user.able?("manager")).should be_true
          end
        end
   end
end
