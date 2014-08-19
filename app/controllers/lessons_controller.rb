class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @lessons = Lesson.all
  end

  def show
  end

  def new
    @lesson = current_user.lessons.build
  end

  def edit
  end

  def create
    @lesson = current_user.lessons.build(lesson_params)
      if @lesson.save
        redirect_to @lesson, notice: 'Lesson was successfully created.'
      else
        render action: 'new'
      end
  end

  def update
    if @lesson.update(lesson_params)
        redirect_to @lesson, notice: 'Lesson was successfully updated.'
      else
        render action: 'edit'
      end
  end

  def destroy
      @lesson.destroy
      redirect_to lessons_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def correct_user
      @lesson = current_user.lessons.find_by(id: params[:id])
      redirect_to lessons_path, notice: "Not authorized to edit this lesson" if @lesson.nil?
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def lesson_params
      params.require(:lesson).permit(:title, :description, :video)
    end
end
