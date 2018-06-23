require "./spec_helper"

describe HashRing do

  it "works" do
    ch = HashRing::HashRing.new(["one", "two", "three"])
    true.should eq(ch.get("user1") == "three")
    true.should eq(ch.get("user2") == "three")
    true.should eq(ch.get("user3") == "one")
    true.should eq(ch.get("user4") == "two")
    
    ch.remove("two")

    true.should eq(ch.get("user1") == "three")
    true.should eq(ch.get("user2") == "three")
    true.should eq(ch.get("user3") == "one")
    true.should eq(ch.get("user4") == "three")
  end
end
