class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  #다운로드 관련
  def p_download
    @download_file = Product.find(params[:id])
    send_file @download_file.p_data.path,
              :filename => @download_file.p_data_file_name,
              :content_type => @download_file.p_data_content_type,
              :disposition => 'attachment'
  end

  def s_download
    @download_file = Product.find(params[:id])
    send_file @download_file.s_data.path,
              :filename => @download_file.s_data_file_name,
              :content_type => @download_file.s_data_content_type,
              :disposition => 'attachment'
  end

  # GET /products
  # GET /products.json
  def index
    session_create()

    @curriculum = Curriculum.find(params[:curriculum_id])
    @products = @curriculum.products.order('lesson ASC')

    lesson_total = @curriculum.total

    #그룹 수
    @group_count = lesson_total /20
    if((lesson_total%20) != 0)
      @group_count += 1
    end

    #그룹 내 차시 수
    @group_lesson = Array.new()

    1.upto(@group_count) do |k|
      if @group_count == k
        @group_lesson[k] = lesson_total % 20
      else
        @group_lesson[k] = 20
      end
    end
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to curriculum_products_path(current_project, current_curriculum), notice: '등록되었습니다.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to curriculum_products_path(current_project, current_curriculum), notice: '수정되었습니다.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def current_project
      @current_project = Project.find(params[:project_id])
    end

    def current_curriculum
      @current_curriculum = Curriculum.find(params[:curriculum_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:curriculum_id, :lesson, :content_use, :p_data, :s_data)
    end
end
