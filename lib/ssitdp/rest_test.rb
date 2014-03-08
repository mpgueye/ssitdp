require 'rest_client'
require 'net/http'
require 'date'

module Ssitdp
  class RestTest
    attr_reader :nb_threads, :url, :params, :methode
    attr :timing

    # Creer un test de type Rest
    # @param params [Hash]
    # @return [Ssitdp::RestTest]

    def initialize(params)
      @nb_threads = params[:nb_threads]
      @url = params[:url]
      @params = params[:params]
      @methode = params[:methode]
      self
    end

    def run!
      @timing = []
      puts 'DEBUT'
      somme = 0
      self.nb_threads.times do |i|
        @timing << [0, 0]
        Thread.new{ somme += self.run_test i }.join
      end
      puts 'FIN'
      puts "moyenne : #{ somme/self.nb_threads } secondes"
    end

    #private

    def run_test i
      if self.methode == :get
        uri = URI self.url
        @timing[i][0] = DateTime.now.to_time
        res = Net::HTTP.get_response uri
        @timing[i][1] = DateTime.now.to_time
        puts "code : #{res.code}"
        puts "message : #{res.message}"
        puts "duree : #{@timing[i][1] - @timing[i][0]} secondes"
        @timing[i][1] - @timing[i][0]
      end
    end
  end
end
