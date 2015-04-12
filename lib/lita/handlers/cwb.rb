require 'open-uri'
require 'nokogiri'

module Lita
  module Handlers
    class Cwb < Handler
      route(/^cwb\s+f(.*)/, :f, command: true, help: { "cwb f [WHERE]" => "Show me forecast information." })

      def f(response)
        where = response.matches.first.first
        case where
          when "台北市"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-009.xml"
          else
            uri = nil
        end

        data = Nokogiri::XML(open(uri)) do |doc|
          response.reply doc.inspect
          response.reply doc.css("dataset location locationName").text

          doc.css("dataset parameterSet parameter").each do |params|
            response.reply params.css("parameterValue").text
          end
        end unless uri.nil?
      end
    end

    Lita.register_handler(Cwb)
  end
end
