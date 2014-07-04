class Admin::BoardsController < ApplicationController
  before_action :set_board, only: [:remove_board]
  def index
    @boards = Board.order("ID DESC").paginate(:page => params[:page], :per_page => 10)

    @boards = Board.order("ID DESC").search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def remove_board
    @board.delete
    respond_to do |format|
      format.html { redirect_to boards_index_path, notice: '글이 삭제되었습니다.' }
      format.json { head :no_content }
    end
  end

  private
    def set_board
      @board = Board.find(params[:id])
    end
end
