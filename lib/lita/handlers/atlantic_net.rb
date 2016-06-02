require "atlantic_net"

module Lita
  module Handlers
    class AtlanticNet < Handler
      config :access_key, required: true
      config :private_key, required: true

      route(/^atlantic\s+instances$/i, :list_instances, command: true, restrict_to: [:atlantic_net_admins], help: {
        t("help.list_instances_key") => t("help.list_instances_value")
      })

      route(/^atlantic\s+reboot\s+(?<instance_id>[0-9]+)$/, :reboot_instance, command: true, restrict_to: [:atlantic_net_admins], help: {
        t("help.reboot_instance_key") => t("help.reboot_instance_value")
      })

      def client
        @client ||= ::AtlanticNet.new(config.access_key, config.private_key)
      end

      def list_instances(response)
        instances = client.list_instances
        if instances and instances.any?
          messages = instances.map { |instance| t("instances.list.detail", Hash[instance.map { |k, v| [k.to_sym, v] }])}
          response.reply(*messages)
        else
          response.reply(t("instances.list.none"))
        end
      end

      def reboot_instance(response)
        instance_id = response.match_data['instance_id']
        response_message = client.reboot_instance(instance_id)
        response.reply(response_message["Message"])
      end

      Lita.register_handler(self)
    end
  end
end
