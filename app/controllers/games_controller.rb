require 'json'
require 'open-uri'

class GamesController < ApplicationController
    attr_accessor :letters
    def new
        @letters = (0...9).map { (65 + rand(26)).chr }
    end

    def score
        @word = params[:word]
        @letters = params[:letters]
        @result = include_letters?(@word, @letters)
        @english_word = url_reader(@word)
        @display_result = result
    end

    def result
        if @result == false
           return  "Sorry but #{@word} can't be built out of #{@letters} "
        else
            return "You win!"
        end
    end

    def include_letters?(word, letters)
        grid_word = word.downcase.split('')
        user_word = letters.downcase.split('')
        grid_word.all? do |letter|
           user_word.count(letter) >= grid_word.count(letter)
        end
    end

    def url_reader(word)
        url = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
        json = JSON.parse(url.read)
        json['found']
    end
end
