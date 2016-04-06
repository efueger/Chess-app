require 'rails_helper'
RSpec.describe Pawn, type: :model do
  describe 'valid_move?' do
    it 'should return true to allow the first move to move two spaces' do
      game = FactoryGirl.create(:game)
      # Select pawn
      white_pawn = game.pieces.find_by_current_row_index_and_current_column_index(1, 0)
      expect(white_pawn.valid_move?(3,0)).to eq true
    end

    it 'should return true if it can move one space forward to an empty spot' do
      game = FactoryGirl.create(:game)
      # Select pawn
      white_pawn = game.pieces.find_by_current_row_index_and_current_column_index(1, 0)
      expect(white_pawn.valid_move?(2,0)).to eq true
    end

    it 'should return false if it tries to move forward into a piece' do
      game = FactoryGirl.create(:game)
      # Select pawn
      white_pawn = game.pieces.find_by_current_row_index_and_current_column_index(1, 0)
      # select black piece
      black_pawn = game.pieces.find_by_current_row_index_and_current_column_index(6, 0)
      # Move black pawn to be in the way
      black_pawn.update_attributes(current_row_index: 2, current_column_index: 0)
      expect(white_pawn.valid_move?(2,0)).to eq false
    end

    it 'should return true for this capture' do
      game = FactoryGirl.create(:game)
      # Select pawn
      white_pawn = game.pieces.find_by_current_row_index_and_current_column_index(1, 0)
      # select black piece
      black_pawn = game.pieces.find_by_current_row_index_and_current_column_index(6, 0)
      # Move black pawn to be in the way
      black_pawn.update_attributes(current_row_index: 2, current_column_index: 1)
      expect(white_pawn.valid_move?(2,1)).to eq true
    end
  end
end
