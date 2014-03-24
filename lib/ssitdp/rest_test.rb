require 'rest_client'
require 'net/http'
require 'date'
require 'benchmark'
require 'csv'

module Ssitdp
  class RestTest
    attr_reader :nb_threads, :url, :params, :methode

    # Creer un test de type Rest
    # @param params [Hash]
    # @return [Ssitdp::RestTest]

    def initialize(params)
      @nb_threads = params[:nb_threads]
      @url        = params[:url]
      @params     = params[:params] || []
      @methode    = params[:methode]
      self
    end

    def run!
      reponses = []
      durees = Benchmark.bm do |x|
        self.nb_threads.times do
          if self.params.count == 0
            Thread.new{ x.report { reponses << self.run_test } }.join
          else
            self.params.each{ |parametres| Thread.new{ x.report { reponses << self.run_test(parametres) } }.join }
          end
        end
      end

      resultats = []
      durees.count.times do |i|
        duree = durees[i].to_a
        code_reponse = reponses[i].code
        resultats << [i, duree[1], duree[2], duree[5], code_reponse]
      end
      resultats
    end

    def run_test(parametres={})
      if self.methode == :get
        return RestClient.get(URI.escape(self.url), {params: parametres})
      end

      if self.methode == :post
        return RestClient.post(URI.escape(self.url), parametres)
      end
    end
  end
end