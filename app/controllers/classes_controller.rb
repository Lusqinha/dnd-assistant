class ClassesController < ApplicationController
  def index
    @classes = DndClass.all.order(:name)

    render inertia: "Classes/Index", props: {
      classes: @classes.as_json(except: [ :created_at, :updated_at ])
    }
  end

  def show
    @class = DndClass.find_by!(index: params[:id])

    render inertia: "Classes/Show", props: {
      dndClass: @class.as_json(except: [ :created_at, :updated_at ])
    }
  end
end
