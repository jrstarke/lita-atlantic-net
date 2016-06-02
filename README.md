# lita-atlantic-net

[![Build Status](https://travis-ci.org/jrstarke/lita-atlantic-net.png?branch=master)](https://travis-ci.org/jrstarke/lita-atlantic-net)
[![Coverage Status](https://coveralls.io/repos/jrstarke/lita-atlantic-net/badge.png)](https://coveralls.io/r/jrstarke/lita-atlantic-net)
[![Gem Version](https://badge.fury.io/rb/lita-atlantic-net.svg)](https://badge.fury.io/rb/lita-atlantic-net)
[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/jrstarke/lita-atlantic-net/master/LICENSE)


**lita-atlantic-net** is a handler plugin for [Lita](https://www.lita.io/) that interacts with [Atlantic.net](https://www.atlantic.net/).

## Installation

Add lita-atlantic-net to your Lita instance's Gemfile:

``` ruby
gem "lita-atlantic-net"
```

## Configuration

### Required attributes

* `access_key` (String) - The access key for your Atlantic.net acccount.
* `private_key` (String) - The private key for your Atlantic.net acccount.

### Example

``` ruby
Lita.configure do |config|
  config.handlers.atlantic_net.access_key = "<your atlantic.net access key>"
  config.handlers.atlantic_net.private_key = "<your atlantic.net private key>"
end
```

## Usage

In order to use the Atlantic.net handler commands, you must ensure that the user running the commands is in the :atlantic_net_admins group.


### List Instances

To list the instances associated with your atlantic.net account:

```
Lita: atlantic instances
```

### Reboot Instance

To reboot an instance associated with your atlantic.net account:

```
Lita: atlantic reboot INSTANCE_ID
```

## License

[MIT](http://opensource.org/licenses/MIT)