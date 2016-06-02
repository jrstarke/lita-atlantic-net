require "lita"

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require "lita/handlers/atlantic_net"

Lita::Handlers::AtlanticNet.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
