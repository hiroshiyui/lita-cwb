module Lita
  module Handlers
    class Cwb < Handler
      route(/^cwb\s+hello/, :hello, command: true, help: { "cwb hello" => "prints 'hello world' from lita-cwb." })

      def hello(response)
        response.reply("Hello world!")
      end
    end

    Lita.register_handler(Cwb)
  end
end
