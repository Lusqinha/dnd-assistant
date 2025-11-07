class SpellsController < ApplicationController
  def index
    @spells = Spell.all.order(:level, :name)

    # Filtros
    @spells = @spells.where(level: params[:level]) if params[:level].present?
    @spells = @spells.where("school->>'name' = ?", params[:school]) if params[:school].present?

    render inertia: "Spells/Index", props: {
      spells: @spells.as_json(except: [ :created_at, :updated_at ]),
      filters: {
        level: params[:level],
        school: params[:school]
      }
    }
  end

  def show
    @spell = Spell.find_by!(index: params[:id])

    render inertia: "Spells/Show", props: {
      spell: @spell.as_json(except: [ :created_at, :updated_at ])
    }
  end
end
