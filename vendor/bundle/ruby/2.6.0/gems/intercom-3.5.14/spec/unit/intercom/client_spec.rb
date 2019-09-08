require 'spec_helper'

module Intercom
  describe Client do
    let(:app_id) { 'myappid' }
    let(:api_key) { 'myapikey' }
    let(:client) { Client.new(app_id: app_id, api_key: api_key) }

    it 'should set the base url' do
      client.base_url.must_equal('https://api.intercom.io')
    end

    it 'should be able to change the base url' do
      prev = client.options(Intercom::Client.set_base_url('https://mymockintercom.io'))
      client.base_url.must_equal('https://mymockintercom.io')
      client.options(prev)
      client.base_url.must_equal('https://api.intercom.io')
    end

    it 'should raise on nil credentials' do
      proc { Client.new(app_id: nil, api_key: nil) }.must_raise MisconfiguredClientError
    end

    describe 'OAuth clients' do
      it 'supports "token"' do
        client = Client.new(token: 'foo')
        client.username_part.must_equal('foo')
        client.password_part.must_equal('')
      end
    end
  end
end
