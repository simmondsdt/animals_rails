class AnimalsController < ApplicationController
  before_action :find_person
  before_action :find_animal, except: [:index, :new, :create]

  def index
    @animals = @person.animals
  end

  def show
  end

  def new
    @animal = @person.animals.new
  end

  def create
    @animal = @person.animals.new(animal_params)
    if @animal.save
      redirect_to person_animal_path(@person, @animal)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @animal.update(animal_params)
      redirect_to person_animal_path(@person, @animal)
    else
      render :edit
    end
  end

  def destroy
    @animal.destroy
    redirect_to person_animals_path(@person)
  end

  private
    def animal_params
      params.require(:animal).permit(:name, :species, :age, :alive)
    end

    def find_person
      @person = Person.find(params[:person_id])
    end

    def find_animal
      @animal = @person.animals.find(params[:id])
    end
end
