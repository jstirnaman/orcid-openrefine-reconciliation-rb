require 'spec_helper'
require 'reconcile'
RSpec.configure do |config|
  config.before(:each) do
    @orcid_base = 'http://pub.sandbox.orcid.org/v1.1/search/orcid-bio'
    stub_request(:get, @orcid_base).
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Host'=>'pub.sandbox.orcid.org', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => "", :headers => {})
  end
end

shared_examples_for OrcidReconciliation do
  let(:reconciler) {described_class.new}
  describe '.service_metadata' do
    specify {
      expect(JSON.parse(reconciler.service_metadata)["name"]).to match(/ORCID/)
    }
  end

  describe '.search' do
      specify {
        response = reconciler.search.body || File.open("spec/orcid-sample.xml")
        doc = Nokogiri::XML(response)
        expect(doc).not_to be_nil
      }

  end

  describe '.to_json' do
    specify {
      expect(reconciler.to_json).not_to be_nil
      expect(JSON.parse(reconciler.to_json)).to be_true
    }  
  end

end

describe OrcidId do
    it_behaves_like OrcidReconciliation
end
