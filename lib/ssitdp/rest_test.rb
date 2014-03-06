require 'rest_client'
require 'net/http'
require 'date'

module Ssitdp
  class RestTest
    attr_reader :nb_threads, :url, :params
    attr :timing

    # Creer un test de type Rest
    # @param params [Hash]
    # @return [Ssitdp::RestTest]

    def initialize(params)
      @nb_threads = params[:nb_threads]
      @url = params[:url]
      @params = params[:params]
      self
    end

    def run!
      @timing = []
      puts 'DEBUT'
      somme = 0
      @nb_threads.times do |i|
        @timing << [0, 0]
        Thread.new{ somme += self.run_test }.join
      end
      puts 'FIN'
      puts "moyenne : #{ somme/n } secondes"
    end

    private

    def run_test
      uri = URI self.url
      @timing[0] = DateTime.now.to_time
      res = Net::HTTP.get_response uri
      @timing[1] = DateTime.now.to_time
      puts "code : #{res.code}"
      puts "message : #{res.message}"
      puts "duree : #{@timing[1] - @timing[0]} secondes"
      @timing[1] - @timing[0]
    end
  end
end
