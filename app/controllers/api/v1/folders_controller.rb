class Api::V1::FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :update, :destroy]

  # GET /folders
  def index
    @folders = Folder.all

    render json: @folders
  end

  # GET /folders/1
  def show
    render json: @folder
  end

  # GET /folder/user/:user_id
  def users_folders
    @user = User.find(params[:user_id])
    
    folders = @user.folders
    render json: folders 
  end

  # POST /folders
  def create
    @folder = Folder.new(folder_params)
    
    if @folder.save
      render json: @folder, status: :created
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /folders/1
  def update
    if @folder.update(folder_params)
      render json: @folder
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  # DELETE /folders/1
  def destroy
    if @folder.destroy
      render json: params[:folder_id]
    else 
      render json: {error: "There Was An Error. Attempt: Destroy Folder."}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def folder_params
      params.require(:folder).permit(:user_id, :folder_name)
    end
end
