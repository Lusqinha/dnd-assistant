<template>
  <div class="min-h-screen bg-gradient-to-br from-purple-900 via-indigo-900 to-blue-900">
    <div class="container mx-auto px-4 py-16">
      <div class="max-w-4xl mx-auto">
        <!-- Header -->
        <div class="text-center mb-12">
          <h1 class="text-6xl font-bold text-white mb-4">
            🎲 D&D Assistant
          </h1>
          <p class="text-xl text-purple-200">
            {{ message }}
          </p>
        </div>

        <!-- Features Grid -->
        <div class="grid md:grid-cols-3 gap-6 mb-12">
          <div class="bg-white/10 backdrop-blur-lg rounded-lg p-6 border border-white/20 hover:bg-white/20 transition">
            <div class="text-4xl mb-3">⚔️</div>
            <h3 class="text-xl font-semibold text-white mb-2">Equipment</h3>
            <p class="text-purple-200">{{ stats.equipment }} items catalogados</p>
          </div>

          <div class="bg-white/10 backdrop-blur-lg rounded-lg p-6 border border-white/20 hover:bg-white/20 transition">
            <div class="text-4xl mb-3">🐉</div>
            <h3 class="text-xl font-semibold text-white mb-2">Monsters</h3>
            <p class="text-purple-200">{{ stats.monsters }} criaturas</p>
          </div>

          <div class="bg-white/10 backdrop-blur-lg rounded-lg p-6 border border-white/20 hover:bg-white/20 transition">
            <div class="text-4xl mb-3">✨</div>
            <h3 class="text-xl font-semibold text-white mb-2">Spells</h3>
            <p class="text-purple-200">{{ stats.spells }} magias</p>
          </div>
        </div>

        <!-- Tech Stack -->
        <div class="bg-white/10 backdrop-blur-lg rounded-lg p-8 border border-white/20">
          <h2 class="text-2xl font-bold text-white mb-6 text-center">
            Tecnologias Utilizadas
          </h2>
          <div class="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
            <div class="bg-white/5 rounded-lg p-4">
              <div class="text-3xl mb-2">💎</div>
              <p class="text-white font-semibold">Rails 8</p>
            </div>
            <div class="bg-white/5 rounded-lg p-4">
              <div class="text-3xl mb-2">💚</div>
              <p class="text-white font-semibold">Vue 3</p>
            </div>
            <div class="bg-white/5 rounded-lg p-4">
              <div class="text-3xl mb-2">⚡</div>
              <p class="text-white font-semibold">Inertia.js</p>
            </div>
            <div class="bg-white/5 rounded-lg p-4">
              <div class="text-3xl mb-2">🎨</div>
              <p class="text-white font-semibold">Tailwind CSS</p>
            </div>
          </div>
        </div>

        <!-- CTA Button -->
        <div class="text-center mt-12">
          <button 
            @click="handleClick"
            class="bg-gradient-to-r from-purple-500 to-indigo-600 hover:from-purple-600 hover:to-indigo-700 text-white font-bold py-4 px-8 rounded-lg shadow-lg transform hover:scale-105 transition duration-200"
          >
            Começar Aventura
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { defineProps } from 'vue'

const props = defineProps({
  message: {
    type: String,
    default: 'Bem-vindo ao seu assistente de D&D!'
  },
  stats: {
    type: Object,
    default: () => ({
      equipment: 0,
      monsters: 0,
      spells: 0
    })
  }
})

const handleClick = () => {
  alert('🎲 Que a sorte esteja com você, aventureiro!')
}
</script>
