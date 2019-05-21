class GetTickerPricesJob < ApplicationJob
  queue_as :default

  def perform
    # binance ws will disconnect after a continuous 24 hour connect.
    def websocket
      binance = Exchange.find_by(name: 'Binance')
      exchange = binance.name
      EM.run {
        pairs = []
        tickers = binance.tickers
        tickers.each {|t| pairs << "#{t.natural_pair.downcase}@tickerArr"}
        pairs = pairs.join("/")
        @ws =  WebSocket::EventMachine::Client.connect( uri:
                    "wss://stream.binance.com:9443/ws/!ticker@arr")
        @ws.onopen do
          p [:open]
        end

        @ws.onmessage do |message, type|
          ticker_stream = JSON.parse message
          ticker_stream.each do |ticker_hash|
            ticker = tickers.find_by natural_pair: ticker_hash["s"]
            if ticker
              price = ticker_hash["c"].to_f
              ProcessTickerJob.perform_later(ticker, price)
            end
          end 
        end

        @ws.onclose do |code, reason|
          p [:close, code, reason]
          ws = nil
          ActiveRecord::Base.connection.close
          EventMachine.stop
        end
       }
     end
    Thread.new do
      loop do
        websocket
        sleep 72000
        Sidekiq::Stats.new.reset
        @ws.close
      end
    end
  end
end
