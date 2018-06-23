require "./hash_ring/*"

module HashRing  
  class HashRing
    @nodes : Array(String)
    @items : Array(Item)
    @replicate : Int32
    
    # Initializes HashRing
    # nodes is an array of node name and replicate is number of each node in the hash ring array.
    #
    # ```
    # HashRing::HashRing.new(["node1", "node2", "node3"])
    # ```
    def initialize(@nodes, @replicate = 512)
      @items = generate_items(@nodes, @replicate)
    end
    
    # Appends a node to tail of the hash ring array.
    # Time complexity of this method is O(n log n) because sort the hash ring array whenever call this method.
    #
    # ```
    # hash_ring = HashRing::Hashring.new(["node1", "node2", "node3"])
    # hash_ring.add("node4")
    # ```
    def add(node : String): Bool
        return false if @nodes.any?{ |e| e == node }
        @nodes << node
        @items = generate_items(@nodes, @replicate)
        true
    end
    
    # Removes node by a node name from the hash ring array.
    # Time complexity of this method is O(n log n) because sort the hash ring array whenever call this method.
    #
    # ```
    # hash_ring = HashRing::Hashring.new(["node1", "node2", "node3"])
    # hash_ring.remove("node4")
    # ```
    def remove(node : String): Bool
      return false if @nodes.all?{ |e| e != node }
      @nodes.delete(node)
      @items = generate_items(@nodes, @replicate)
      true
    end
    
    # Returns a node name.
    #
    # ```
    # hash_ring = HashRing::Hashring.new(["node1", "node2", "node3"])
    # hash_ring.get("user1") # => "node3"
    # ```
    def get(node : String): String
      return @items.last.node if @items.last.hash < Utils.hash(node)
      @items[find_item_index(node)].node
    end
    
    # :nodoc:
    private def generate_items(nodes : Array(String), default_num_replicas : Int32): Array(Item)
      node_list = nodes.map do |node|
        (0...default_num_replicas).map do |replica|
          Item.new(node, replica)
        end
      end
      node_list.flatten.sort
    end
    
    # Searches a node from @nodes by the binary search and returns the index.
    # :nodoc:
    private def find_item_index(node : String): Int32
      left, right = 0, @items.size
      key_hash = Utils.hash(node)
      while (right - left) > 1
          mid = (left + right) >> 1
          return mid if @items[mid].hash ==  key_hash
          if key_hash < @items[mid].hash
            right = mid
          else
            left = mid
          end  
      end
      left
    end
  end
end
