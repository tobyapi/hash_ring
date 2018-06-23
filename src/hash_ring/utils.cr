require "Digest"
require "./item"

module HashRing::Utils
  extend self
  include HashRing

  def hash(key)
     return Digest::MD5.hexdigest(key)[16,16].to_u64(16)
  end
end