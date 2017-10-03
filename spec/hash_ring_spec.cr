require "./spec_helper"

describe HashRing do

  it "works" do
    ch = HashRing::ConsistentHash(String).new(["one", "two", "three"])
    true.should eq(ch.get("user1") == "two")
    true.should eq(ch.get("user2") == "two")
    true.should eq(ch.get("user3") == "one")
    true.should eq(ch.get("user4") == "three")
    
    ch.remove("two")
    
    true.should eq(ch.get("user1") == "three")
    true.should eq(ch.get("user2") == "one")
    true.should eq(ch.get("user3") == "one")
    true.should eq(ch.get("user4") == "three")
  end
end
