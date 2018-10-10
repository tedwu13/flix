class MoviesController < ApplicationController

  def index
    @time = Time.now.strftime("%T")
    # @movies = Movie.all
    @movies = Movie.released # implement upcoming
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update(movie_params)

      flash[:notice] = "Movie successfully updated"
      redirect_to movie_path(@movie)
    else
      flash[:notice] = "Movie failed to update"
      render :edit
    end

  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: "Movie successfully created"
    else
      flash[:notice] = "Movie failed to create"
      render :new
    end
  end

  def destroy
    @movie = Movie.find(params[:id]).destroy
    redirect_to movies_path(@movie)
  end


  private
  def movie_params
    params.require(:movie).
      permit(:title, :description, :rating, :released_on, :total_gross, :cast, :director, :duration, :image_file_name)
  end

end
