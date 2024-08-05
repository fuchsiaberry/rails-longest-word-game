require 'open-uri'
require 'json'
require 'net/http'

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].downcase.split(//)
    @word_split = params[:word].split(//)
    @letter_check = true

    # check if the word exists
    url = "https://dictionary.lewagon.com/#{params[:word]}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @data = JSON.parse(response)
    @word_check = true

    # check if the word doesn't use letters twice
    @word_split.each do |word_letter|
      if @letters.include?(word_letter)
        @letters.delete(word_letter)
      else
        @letter_check = false
      end
    end
  end
end
