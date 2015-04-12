require 'open-uri'
require 'nokogiri'

module Lita
  module Handlers
    class Cwb < Handler
      route(/^cwb\s+f\s(.*)/, :f, command: true, help: { "cwb f [WHERE]" => "Show me forecast information." })

      def f(response)
        where = response.matches.first.first
        case where
          when "台北市"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-009.xml"
          else
            response.reply t "No weather information for location #{where}"
            return
        end

        data = Nokogiri::XML(open(uri))
        response.reply data.css("dataset location locationName").text
        data.css("dataset parameterSet parameter").each do |params|
          response.reply params.css("parameterValue").text
        end
      end
    end

    Lita.register_handler(Cwb)
  end
end
