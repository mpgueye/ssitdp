require 'rest_client'
require 'net/http'
require 'date'
require 'benchmark'

module Ssitdp
  class RestTest
    attr_reader :nb_threads, :url, :params, :methode
    attr :timing

    # Creer un test de type Rest
    # @param params [Hash]
    # @return [Ssitdp::RestTest]

    def initialize(params)
      @nb_threads = params[:nb_threads]
      @url        = params[:url]
      @params     = params[:params]
      @methode    = params[:methode]
      self
    end

    def run!
      @timing = []
      Benchmark.bm do |x|
        self.nb_threads.times do
          Thread.new{ x.report { self.run_test } }.join
        end
      end
    end

    #private

    def run_test
      if self.methode == :get
        Net::HTTP.get_response URI(self.url)
      end

      if self.methode == :post
        Net::HTTP.post_form URI(self.url), self.params
      end
    end
  end
end