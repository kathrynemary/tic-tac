#should test if computer almost winning, human almost winning, neither almost winning
#test that length of input must be 1 character.

gem 'minitest'
require 'minitest/autorun'
require './game'

describe Game do
  before do
    @computer = "X"
    @human = "O"
    @game = :play_loop
    @find_available_spaces = :find_available_spaces
  end

  it "must be valid" do
    Game.must_respond_to :new
  end

  it "should count less than 9 available spaces" do
    @find_available_spaces.length.must_be :<, 9
  end
end
