require 'spec_helper'

describe Display do
  let(:adapter)       { stub(:password => 'password', :username => 'username') }
  let(:client)        { stub(:adapter => adapter) }
  let(:display_name)  { 'recent-transactions' }
  let(:data)          { { customer_id: SecureRandom.uuid } }
  let(:display)       { described_class.new(client:  client,
                                            name:    display_name,
                                            data:    data ) }

  let(:jwt) { JWT.encode(
                {
                  display:       display_name,
                  application_id: client.adapter.username,
                  iat:            Time.now.to_i,
                  data:           data
                  },
                  client.adapter.password
              )
            }

  describe "#token" do
    it 'encodes a JWT' do
      display.token.should eql(jwt)
    end
  end

  context 'it has a valid workflow name' do
    subject { display }
    it { should be_valid_display_name }
  end

  context 'it has an invalid display name' do
    let(:display) { display.new(name: 'not a valid display name') }
    it 'raises' do
      expect { display.valid_workflow_name? }.to raise_error
    end
  end
end
