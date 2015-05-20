class Workflow
  attr_accessor :client, :data, :name
  VALID_WORKFLOW_NAMES = ['enrollment', 'manage-accounts','merchant-registration','payment']

  def initialize(options = {})
    self.client = options[:client]
    self.data = options[:data]
    self.name = options[:name]
  end

  def token
    if valid_workflow_name?
      JWT.encode(
        {
          workflow: name,
          application_id: client.adapter.username,
          iat:     Time.now.to_i,
          data:    data
        },
        client.adapter.password
      )
    end
  end

  def valid_workflow_name?
    if VALID_WORKFLOW_NAMES.include?(name)
      true
    else
      raise "Not a valid workflow name"
    end
  end
end