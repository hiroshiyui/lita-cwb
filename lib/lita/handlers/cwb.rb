require 'open-uri'
require 'nokogiri'

module Lita
  module Handlers
    class Cwb < Handler
      route(/^cwb\s+f\s(.*)/, :f, command: true, help: { "cwb f [WHERE]" => "Show me forecast information for location WHERE." })

      def f(response)
        where = response.matches.first.first
        where.strip!
        where.sub!('臺', '台')

        case where
          when "台北市", "台北"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-009.xml"
          when "新北市", "新北"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-010.xml"
          when "基隆市", "基隆", "雞籠"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-011.xml"
          when "花蓮縣", "花蓮", "洄瀾"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-012.xml"
          when "宜蘭縣", "宜蘭"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-013.xml"
          when "金門縣", "金門"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-014.xml"
          when "澎湖縣", "澎湖"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-015.xml"
          when "台南市", "台南"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-016.xml"
          when "高雄市", "高雄", "打狗"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-017.xml"
          when "嘉義縣"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-018.xml"
          when "嘉義市"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-019.xml"
          when "苗栗縣", "苗栗"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-020.xml"
          when "台中市", "台中"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-021.xml"
          when "桃園市", "桃園"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-022.xml"
          when "新竹縣"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-023.xml"
          when "新竹市"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-024.xml"
          when "屏東縣", "屏東"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-025.xml"
          when "南投縣", "南投"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-026.xml"
          when "台東縣", "台東"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-027.xml"
          when "彰化縣", "彰化"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-028.xml"
          when "雲林縣", "雲林"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-029.xml"
          when "連江縣", "馬祖"
            uri = "http://opendata.cwb.gov.tw/opendata/MFC/F-C0032-030.xml"
          else
            response.reply t('not_match_location', {:where => where})
            return
        end

        data = Nokogiri::XML(open(uri)) do |config|
          config.strict.noblanks
        end

        response.reply data.css("dataset location locationName").text
        data.css("dataset parameterSet parameter").each do |param|
          response.reply param.css("parameterValue").text
        end
      end
    end

    Lita.register_handler(Cwb)
  end
end
