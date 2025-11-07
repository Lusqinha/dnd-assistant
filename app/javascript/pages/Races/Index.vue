<script setup>
import { Link } from '@inertiajs/vue3'
import AppLayout from '@/layouts/AppLayout.vue'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'

defineProps({
  races: Array
})

const getRaceIcon = (raceName) => {
  const icons = {
    'Dragonborn': '🐉',
    'Dwarf': '⛏️',
    'Elf': '🏹',
    'Gnome': '🔬',
    'Half-Elf': '✨',
    'Half-Orc': '💪',
    'Halfling': '🍀',
    'Human': '👤',
    'Tiefling': '😈'
  }
  return icons[raceName] || '👥'
}
</script>

<template>
  <AppLayout title="Raças">
    <div class="mx-auto max-w-7xl">
      <!-- Header -->
      <div class="mb-8">
        <h2 class="text-3xl font-bold tracking-tight">Raças Jogáveis</h2>
        <p class="text-muted-foreground mt-2">
          Explore as {{ races.length }} raças disponíveis no D&D 5e
        </p>
      </div>

      <!-- Races Grid -->
      <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
        <Link
          v-for="race in races"
          :key="race.id"
          :href="`/races/${race.index}`"
          class="group"
        >
          <Card class="h-full transition-all hover:shadow-lg hover:border-primary/50">
            <CardHeader>
              <div class="flex items-start justify-between">
                <div class="text-4xl mb-2">{{ getRaceIcon(race.name) }}</div>
                <Badge variant="secondary" class="text-xs">
                  {{ race.speed }}ft
                </Badge>
              </div>
              <CardTitle class="group-hover:text-primary transition-colors">
                {{ race.name }}
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div class="space-y-3">
                <!-- Speed -->
                <div class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Velocidade</span>
                  <span class="font-medium">{{ race.speed }} pés</span>
                </div>

                <!-- Size -->
                <div class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Tamanho</span>
                  <Badge variant="outline" class="text-xs">{{ race.size }}</Badge>
                </div>

                <!-- Ability Bonuses -->
                <div v-if="race.ability_bonuses && race.ability_bonuses.length > 0">
                  <p class="text-xs text-muted-foreground mb-1">Bônus de Atributos:</p>
                  <div class="flex flex-wrap gap-1">
                    <Badge 
                      v-for="(bonus, idx) in race.ability_bonuses.slice(0, 3)" 
                      :key="idx"
                      variant="default"
                      class="text-xs"
                    >
                      +{{ bonus.bonus }} {{ bonus.ability_score?.name }}
                    </Badge>
                    <Badge 
                      v-if="race.ability_bonuses.length > 3"
                      variant="outline"
                      class="text-xs"
                    >
                      +{{ race.ability_bonuses.length - 3 }}
                    </Badge>
                  </div>
                </div>

                <!-- Languages -->
                <div v-if="race.languages && race.languages.length > 0" class="flex items-center gap-2">
                  <span class="text-xs text-muted-foreground">
                    💬 {{ race.languages.length }} idioma(s)
                  </span>
                </div>
              </div>
            </CardContent>
          </Card>
        </Link>
      </div>

      <!-- Empty State -->
      <div v-if="!races || races.length === 0" class="text-center py-12">
        <p class="text-muted-foreground">Nenhuma raça encontrada</p>
      </div>
    </div>
  </AppLayout>
</template>
