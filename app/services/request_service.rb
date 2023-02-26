require 'net/http'
require 'json'

class RequestService
  def initialize(zip, user)
    @user = user
    @address = Address.find_by_zipcode(zip.gsub('-',''))
    unless @address.present?
      endpoint = "http://cep.la/#{zip}"
      uri = URI.parse(endpoint)
      @http = Net::HTTP.new(uri.host)
      @http.read_timeout = 2
      @req = Net::HTTP::Get.new(endpoint, {'Content-Type' => 'application/json', 'Accept' => 'application/json'})
    end
  end

  def result
    if @address.present?
      [@address.result,:ok]
    else
      begin
        res = prepare_return_json(JSON.parse(@http.request(@req).body))
        AddressCreatorJob.perform_later(address_attributes: res,
                                        user_id: user.id)
        [res, :ok]
      rescue Net::ReadTimeout
      rescue Net::OpenTimeout
        [{},:request_timeout]
      rescue Exception
        [{}, :internal_server_error]
      end
    end
  end

  private

  attr_reader :user

  def prepare_return_json(data)
    zip = data['cep'].gsub('-','')
    {
      street: data['logradouro'],
      address: "#{data['logradouro']}, #{data['bairro']} - #{data['cidade']}/#{data['uf']} #{zip}",
      neighborhood: data['bairro'],
      city: data['cidade'],
      state: data['uf'],
      zipcode: zip
    }
  end
end
