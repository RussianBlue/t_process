class Admin::CurriculumsController < ApplicationController
  before_action :set_curriculums, only: [:remove_curriculum]
  def index
    @curriculums = Curriculum.paginate(:page => params[:page], :per_page => 10)

    @curriculums = Curriculum.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
  end

  def remove_curriculum
    1.upto(@curriculum.total) do |i|
      progress = Progress.where(:curriculum_id => @curriculum.id, :lesson => i.to_i)
      progress.each do |process|
        process.delete
      end

      #최종산출물 삭제
      products = Product.where(:curriculum_id => @curriculum.id, :lesson => i.to_i)
      
      products.each do |product|
        product.delete
      end
    end

    @curriculum.delete
    respond_to do |format|
      format.html { redirect_to curriculums_index_path, notice: '해당 과정이 삭제되었습니다.' }
      format.json { head :no_content }
    end
  end

  private
    def set_curriculums
      @curriculum = Curriculum.find(params[:id])
    end
end
