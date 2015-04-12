require 'open-uri'
require 'nokogiri'

module Lita
  module Handlers
    class Cwb < Handler
      route(/^cwb\s+hello/, :hello, command: true, help: { "cwb hello" => "prints 'hello world' from lita-cwb." })
      route(/^cwb\s+f\s+(.*)/, :f, command: true, help: { "cwb f [WHERE]" => "Show me forecast information." })

      def hello(response)
        response.reply("Hello world!")
      end

      def f(response)
        where = response.matches.first.first
        uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-009.xml"
        data = Nokogiri::XML(open(uri)) do |doc|
          response.reply doc.css("dataset location locationName").text

          doc.css("dataset parameterSet parameter").each do |params|
            response.reply params.css("parameterValue").text
          end
        end
      end
    end

    Lita.register_handler(Cwb)
  end
end
