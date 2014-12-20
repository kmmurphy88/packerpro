class PacklistsController < ApplicationController
  before_action :set_packlist, only: [:show, :edit, :update, :destroy]

  def new
    @packlist = Packlist.new
    @country_options = ["In Country", "Out of Country"]
    @temp = [["Freezing"], ["Cool"], ["Warm"], ["Blazing"]]
    @time_frame = (1..30).to_a
    @activity_list = ['Outdoor Activities', 'Indoor Actvities']
  end

  # def index
  #   @packlists = Packlist.all
  # end

  def create
    params["packlist"]["weather"] = params["packlist"]["weather"].reject {|x| x.empty?}.join(",")
    @packlist = Packlist.new(packlist_params)
    # raise 'the roof'
    if @packlist.save
      redirect_to packlist_path(@packlist)
    else
      render :new
    end
  end

  def edit
    @packlist = Packlist.find(params[:id])
  end

  def update
    @packlist = Packlist.find(params[:id])
    if @packlist.update_attributes(post_params)
      redirect_to packlist_path(packlist)
    else
      render :edit
    end
  end

  def destroy
    @packlist = Packlist.find(params[:id])
    if @packlist.destroy
      redirect_to packlist_path
    else
      render :new
    end
  end

  def show
    @items = @packlist.items
  end

  def send_list
    @packlist = Packlist.find(params[:packlist_id])
    PacklistMailer.list_email(params[:packlist][:email], @packlist.id).deliver
    redirect_to @packlist, notice: 'Email sent!'
  end

  private

  def set_packlist
    @packlist = Packlist.find(params[:id])
  end

  def packlist_params
    params.require(:packlist).permit(:where, :how_long, :weather, :activities)
  end
end
