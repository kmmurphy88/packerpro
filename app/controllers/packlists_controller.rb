class PacklistsController < ApplicationController
  before_action :set_packlist only: [:show, :edit, :update, :destroy]

  def new
    @packlist = Packlist.new
  end

  def index
    @packlists = Packlist.all
  end

  def create
    @packlist = Packlist.create(packlist_params)
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
  end

  private

  def set_packlist
    @packlist = Packlist.find(params[:id])
  end

  def packlist_params
    params.require(:packlist).permit(:where, :how_long, :weather, :activities)
  end
end
