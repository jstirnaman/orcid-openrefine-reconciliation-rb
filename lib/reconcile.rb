# Reconciliation Service for ORCID Public Search API
require 'uri'
require 'net/http'
require 'nokogiri'
require 'json'
require 'jbuilder'

module OrcidReconciliation

def orcid_base
  orcid_base = 'http://pub.sandbox.orcid.org/v1.1/search/orcid-bio'
end

def service_metadata
service_metadata = { "name" => "Simple ORCID Reconciliation", "identifierSpace" => "profile.id", "schemaSpace" => "profile.id", "defaultTypes" => { "id" => "/profile/id", "name" => "Identifier" } }
service_metadata = JSON.generate(service_metadata)
end

def get
  search
end

def to_json
d = get.body
doc = Nokogiri::XML(d)
doc.css("orcid-search-result orcid-profile")
end

def search
  uri = URI(orcid_base)
  Net::HTTP.get_response(uri)
end

def to_jsonp
end

end

class OrcidId
  include OrcidReconciliation
end
