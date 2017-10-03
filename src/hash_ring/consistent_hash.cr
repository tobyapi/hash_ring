require "murmur3"

module HashRing
  class ConsistentHash(T)
    @key_cache : Array(UInt64)
    
    def initialize(nodes : Enumerable(T))
      initialize(nodes, nodes.size)
    end
    
    def initialize(nodes : Enumerable(T), @replicate : Int32)
      @ring = Hash(UInt64,T).new
      nodes.each { |node| add(node, false) }
      @key_cache = @ring.keys.sort!
    end
    
    def add(node : T)
      add(node, true)
    end
    
    private def add(node : T, update_key_array : Bool)
      (0...@replicate).each do |i|
        hash = better_hash(node.hash.to_s + i.to_s)
        @ring[hash] = node
      end
      @key_cache = @ring.keys.sort! if update_key_array
    end
    
    def remove(node : T)
      (0...@replicate).each do |i|
        hash = better_hash(node.hash.to_s + i.to_s)
        raise "can not remove a node that not added" unless @ring.delete(hash)
      end
      @key_cache = @ring.keys.sort!
    end
    
    private def first(key : UInt64)
      left, right = 0, @key_cache.size - 1
      return 0 if key < @key_cache[left] || @key_cache[right] < key
      
      while right - left > 1 
        mid = (left + right) >> 1
        if @key_cache[mid] <= key
          left = mid
        else
          right = mid
        end
      end
      raise "should not happen" if key < @key_cache[left] || @key_cache[right] < key
      return left
    end
    
    def get(key : String)
      fst = first(better_hash(key))
      @ring[@key_cache[fst]]
    end
    
    private def better_hash(key : String)
      Murmur3.h1(key)
    end
  end
end