require "spec_helper"

describe Lita::Handlers::AtlanticNet, lita_handler: true do

  # Chat routes
  it { 
    is_expected.to route_command("atlantic instances").with_authorization_for(:atlantic_net_admins).to(:list_instances) 
    is_expected.to route_command("atlantic reboot 1").with_authorization_for(:atlantic_net_admins).to(:reboot_instance)
  }

  let(:client) { instance_double("::AtlanticNet") }


  before do
    Lita.config.handlers.atlantic_net.access_key = 'foo'
    Lita.config.handlers.atlantic_net.private_key = 'bar'

    robot.auth.add_user_to_group!(user, :atlantic_net_admins)

    allow(::AtlanticNet).to receive(:new).and_return(client)
  end

  describe "#list instances" do
    context "There are instances" do
      let(:instances) {
        [
          {
            "InstanceId" => "145607",
            "vm_description" => "New",
            "vm_ip_address" => "209.208.65.177",
            "vm_plan_name" => "S",
            "vm_status" => "RUNNING"
          },
          {
            "InstanceId" => "153979",
            "vm_description" => "apitestserver",
            "vm_ip_address" => "45.58.35.251",
            "vm_plan_name" => "L",
            "vm_status" => "RUNNING" 
          }
        ]
      }

      it "lists all instances" do
        allow(client).to receive(:list_instances).and_return(instances)
        send_command("atlantic instances")
        expect(replies).to eq [
          "ID: 145607, Description: New, IP: 209.208.65.177, Plan: S, Status: RUNNING",
          "ID: 153979, Description: apitestserver, IP: 45.58.35.251, Plan: L, Status: RUNNING",
        ]
      end
    end

    context "No instances" do
      let(:instances) {
        []
      }

      it "responds with no instances" do
        allow(client).to receive(:list_instances).and_return(instances)
        send_command("atlantic instances")
        expect(replies).to eq [
          "No instances on your account."
        ]
      end
    end
  end

  describe "#reboot instance" do
    let(:response) {
      {
        "Message" => "Successfully queued for reboot",
        "value" => "true"
      }
    }

    it "reboots the server" do
      allow(client).to receive(:reboot_instance).and_return(response)
      send_command("atlantic reboot 12")
      expect(replies).to eq [
        "Successfully queued for reboot"
      ]
    end
  end
end
