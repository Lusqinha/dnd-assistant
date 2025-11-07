class MonstersController < ApplicationController
  def index
    @monsters = Monster.all.order(:challenge_rating, :name)

    # Filtros
    @monsters = @monsters.where(type: params[:type]) if params[:type].present?
    @monsters = @monsters.where(challenge_rating: params[:cr]) if params[:cr].present?

    render inertia: "Monsters/Index", props: {
      monsters: @monsters.as_json(except: [ :created_at, :updated_at ]),
      filters: {
        type: params[:type],
        cr: params[:cr]
      }
    }
  end

  def show
    @monster = Monster.find_by!(index: params[:id])

    render inertia: "Monsters/Show", props: {
      monster: @monster.as_json(except: [ :created_at, :updated_at ])
    }
  end
end
