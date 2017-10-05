require 'rspec'
require_relative '../lib/game.rb'
require_relative '../lib/result_printer.rb'
require_relative '../lib/word_reader.rb'

describe Game do
  it 'Good Game' do
    good_game = Game.new('загадка')
    good_game.next_step('з')
    good_game.next_step('а')
    good_game.next_step('г')
    good_game.next_step('а')
    good_game.next_step('д')
    good_game.next_step('к')
    good_game.next_step('а')
    expect(good_game.bad_letters.size).to eq 0
    expect(good_game.status).to eq 1
  end

  it 'Bad Game' do
    good_game = Game.new('загадка')
    good_game.next_step('ж')
    good_game.next_step('о')
    good_game.next_step('п')
    good_game.next_step('а')
    good_game.next_step('д')
    good_game.next_step('и')
    good_game.next_step('е')
    good_game.next_step('ц')
    good_game.next_step('р')
    expect(good_game.bad_letters.size).to eq 7
    expect(good_game.status).to eq -1
  end
end
