class RacesController < ApplicationController
  def index
    @races = Race.all.order(:name)

    render inertia: "Races/Index", props: {
      races: @races.as_json(except: [ :created_at, :updated_at ])
    }
  end

  def show
    @race = Race.find_by!(index: params[:id])

    render inertia: "Races/Show", props: {
      race: @race.as_json(except: [ :created_at, :updated_at ])
    }
  end
end
