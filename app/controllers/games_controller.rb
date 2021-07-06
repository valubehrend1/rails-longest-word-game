class GamesController < ApplicationController
    attr_accessor :letters
    def new
        @letters = (0...9).map { (65 + rand(26)).chr }
    end

    def score
        @word = params[:word]
    end
end
