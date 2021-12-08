class UserBank
    include ActiveModel::Model

    require 'net/https'
    require 'uri'
    require 'json'
    require 'logger'

    def connection(dir, limit = 10)

        @uri = "https://sample-accounts-api.herokuapp.com"

        # [ロガー]
        logger = Logger.new('log/webapi.log')
        raise ArgumentError, 'too many HTTP redirects' if limit == 0

        # WebAPIのURIを生成
        uri = URI.parse("#{@uri}#{dir}")

        begin
            response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
            http.open_timeout = 5
            http.read_timeout = 10
            http.get(uri.request_uri)
            end

            case response
            when Net::HTTPSuccess
                json = response.body
                return JSON.parse(json, symbolize_names: true)
            when Net::HTTPRedirection
                location = response['location']
                warn "redirected to #{location}"
                get_json(location, limit - 1)

                logger.warn("redirected to #{location}")
            else
                logger.warn("#{uri.to_s},#{response.value}")
                return nil
            end
        rescue => e
            logger.warn("#{uri.to_s},#{e.class}")
            return nil
        end
    end

end
