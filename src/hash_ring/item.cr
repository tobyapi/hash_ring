require "./utils"

module HashRing
  struct Item
    include Comparable(self)
    
    getter hash : UInt64
    getter node : String
    
    def initialize(@node, replica : Int32)
      @hash = Utils.hash("#{@node}#{replica}")
    end
    
    def <=>(other : self)
      @hash <=> other.hash
    end
  end
end