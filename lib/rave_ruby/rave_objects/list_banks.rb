require_relative "base/base.rb"

class ListBanks < Base

    attr_reader :rave_object

    # method to initialize the object
    def initialize(rave_object)
        @rave_object = rave_object
    end

    # method to fetch the list of banks using the list bank endpoint
    def fetch_banks
        base_url = rave_object.base_url
        response = get_request("#{base_url}#{BASE_ENDPOINTS::BANKS_ENDPOINT}", {:json => 1})
        return handle_list_bank(response)
    end

    def fetch_country_banks(country)
        base_url = rave_object.base_url
        response = get_request("#{base_url}#{BASE_ENDPOINTS::COUNTRY_BANKS_ENDPOINT}/#{country}", {public_key: rave_object.public_key, :json => 1})
        if response.code == 200
            response = {"error" => false, "data" => JSON.parse(response.body)['data']['Banks']}
        else
            response = {"error" => true, "data" => JSON.parse(response.body)}
        end
        return response
    end
end
