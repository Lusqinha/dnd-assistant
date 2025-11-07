class HomeController < ApplicationController
  def index
    render inertia: "Home/Index", props: {
      message: "Configuração completa com Vue 3, Inertia.js e Tailwind CSS! 🎉",
      stats: {
        equipment: Equipment.count,
        monsters: Monster.count,
        spells: Spell.count
      }
    }
  end
end
