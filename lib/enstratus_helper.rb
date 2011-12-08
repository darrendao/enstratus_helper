require 'rubygems'
require 'base64'
require 'rest_client'
require 'digest/sha2'
require 'openssl'
require 'uri'

class EnstratusHelper
  CONFIGURABLE_ATTRIBUTES = [
    :details,
    :accept,
    :secret_key,
    :access_key
  ]
  attr_accessor *CONFIGURABLE_ATTRIBUTES

  def initialize(options = {})
    CONFIGURABLE_ATTRIBUTES.each do |attribute_name|
      self.send("#{attribute_name}=", options[attribute_name]) if options.has_key?(attribute_name)
    end
    @accept ||= 'application/json'
    @details ||= 'extended'
  end

  # Generates the required headers for talking to enStratus API
  # signature is of the following format:
  #   BASE64(SHA256(ACCESS_KEY:METHOD:URI:TIMESTAMP:USER_AGENT))
  def generate_header(uri, http_method, options={})
    path = URI.parse(uri).path
    timestamp = Time.now.to_i * 1000
    signature = "#{@access_key}:#{http_method}:#{path}:#{timestamp}:#{self.class}"
    signature = EnstratusHelper::sign(@secret_key, signature)
    {'x-esauth-access' => @access_key, 'x-esauth-signature' => signature,
     'x-esauth-timestamp' => timestamp, 'User-agent' => self.class,
     'x-es-details' => details, 'Accept' => accept}
  end

  # Sends the request to the given URI using the specified method (GET by default)
  # Returns the response object (of the rest-client library)
  def request(uri, method="GET")
    response = nil
    begin
      header = generate_header(uri, method)
      response = RestClient.get uri, header
    rescue => e
      puts e.inspect
    end
    response
  end

  # Generates the signature for talking to enStratus
  def self.sign(key, str_to_sign)
    digest = OpenSSL::Digest::Digest.new('sha256')
    Base64.encode64(OpenSSL::HMAC.digest(digest, key, str_to_sign)).gsub("\n","")
  end
end
