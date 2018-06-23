[![Build Status](https://travis-ci.org/TobiasGSmollett/hash_ring.svg?branch=master)](https://travis-ci.org/TobiasGSmollett/hash_ring)

# hash_ring
The Consistent Hash Ring is a useful data structure when you operate the distributed servers. This library is implementation of Consistent Hash Ring based on the excellent [Elixir hash ring lib](https://github.com/discordapp/ex_hash_ring).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  hash_ring:
    github: TobiasGSmollett/hash_ring
```

## Usage

```crystal
require "hash_ring"

# Register 3 servers
hash_ring = HashRing::HashRing.new(["one", "two", "three"])

# Every user is assigned a server by consistent hash ring.
hash_ring.get("user1") # => "three"
hash_ring.get("user2") # => "three"
hash_ring.get("user3") # => "one"
hash_ring.get("user4") # => "two"

# Removes the "two" server
hash_ring.remove("two")

# Exists two servers which are "one" and "three".
hash_ring.get("user1") # => "three"
hash_ring.get("user2") # => "three"
hash_ring.get("user3") # => "one"
hash_ring.get("user4") # => "three"
```

## Contributing

1. Fork it ( https://github.com/TobiasGSmollett/hash_ring/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [tobias](https://github.com/TobiasGSmollett) TobiasGSmollett - creator, maintainer
