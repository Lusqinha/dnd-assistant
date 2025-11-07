class EquipmentController < ApplicationController
  def index
    @equipment = Equipment.all.order(:name)

    # Filtros
    @equipment = @equipment.where(gear_category: params[:category]) if params[:category].present?

    render inertia: "Equipment/Index", props: {
      equipment: @equipment.as_json(except: [ :created_at, :updated_at ]),
      filters: {
        category: params[:category]
      }
    }
  end

  def show
    @item = Equipment.find_by!(index: params[:id])

    render inertia: "Equipment/Show", props: {
      item: @item.as_json(except: [ :created_at, :updated_at ])
    }
  end
end
