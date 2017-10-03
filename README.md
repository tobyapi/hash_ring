# hash_ring

**WIP**

The Consistent Hash Ring is a useful data structure when you operate the distributed servers. This library is implementation of Consistent Hash Ring with Crystal language.

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
ch = HashRing::ConsistentHash(String).new(["one", "two", "three"])

# Every user is assigned a server by consistent hash ring.
ch.get("user1") # => "two"
ch.get("user2") # => "two"
ch.get("user3") # => "one"
ch.get("user4") # => "three"

# Removes the "two" server
ch.remove("two")

# Exists two servers which are "one" and "three".
ch.get("user1") # => "three"
ch.get("user2") # => "one"
ch.get("user3") # => "one"
ch.get("user4") # => "three"
```

## Development

TODO: Implements SortedList or SortedHash with O(log n).

## Contributing

1. Fork it ( https://github.com/TobiasGSmollett/hash_ring/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [tobias](https://github.com/TobiasGSmollett) TobiasGSmollett - creator, maintainer
