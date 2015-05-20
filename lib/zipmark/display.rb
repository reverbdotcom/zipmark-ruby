class Display
  attr_accessor :client, :data, :name

  VALID_DISPLAY_NAMES = ['recent-transactions','accounts']

  def initialize(options = {})
    self.client = options[:client]
    self.data = options[:data]
    self.name = options[:name]
  end

  def token
    if valid_display_name?
      JWT.encode(
        {
          display: name,
          application_id: client.adapter.username,
          iat:     Time.now.to_i,
          data:    data
        },
        client.adapter.password
      )
    end
  end

  def valid_display_name?
    if VALID_DISPLAY_NAMES.include?(name)
      true
    else
      raise "Not a valid display name"
    end
  end
end
