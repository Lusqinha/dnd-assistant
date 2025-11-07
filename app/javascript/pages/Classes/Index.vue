<script setup>
import { Link } from '@inertiajs/vue3'
import AppLayout from '@/layouts/AppLayout.vue'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'

defineProps({
  classes: Array
})

const getClassIcon = (className) => {
  const icons = {
    'Barbarian': '⚔️',
    'Bard': '🎵',
    'Cleric': '✨',
    'Druid': '🍃',
    'Fighter': '🛡️',
    'Monk': '🥋',
    'Paladin': '⚡',
    'Ranger': '🏹',
    'Rogue': '🗡️',
    'Sorcerer': '🔮',
    'Warlock': '👁️',
    'Wizard': '📚'
  }
  return icons[className] || '🎲'
}
</script>

<template>
  <AppLayout title="Classes">
    <div class="mx-auto max-w-7xl">
      <!-- Header -->
      <div class="mb-8">
        <h2 class="text-3xl font-bold tracking-tight">Classes de Personagem</h2>
        <p class="text-muted-foreground mt-2">
          Explore as 12 classes disponíveis no D&D 5e
        </p>
      </div>

      <!-- Classes Grid -->
      <div class="grid gap-6 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        <Link
          v-for="dndClass in classes"
          :key="dndClass.id"
          :href="`/classes/${dndClass.index}`"
          class="group"
        >
          <Card class="h-full transition-all hover:shadow-lg hover:border-primary/50">
            <CardHeader>
              <div class="flex items-start justify-between">
                <div class="text-4xl mb-2">{{ getClassIcon(dndClass.name) }}</div>
                <Badge variant="secondary" class="text-xs">
                  d{{ dndClass.hit_die }}
                </Badge>
              </div>
              <CardTitle class="group-hover:text-primary transition-colors">
                {{ dndClass.name }}
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div class="space-y-3">
                <!-- Hit Die -->
                <div class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Dado de Vida</span>
                  <span class="font-medium">d{{ dndClass.hit_die }}</span>
                </div>

                <!-- Proficiências -->
                <div v-if="dndClass.proficiencies && dndClass.proficiencies.length > 0">
                  <p class="text-xs text-muted-foreground mb-1">Proficiências:</p>
                  <div class="flex flex-wrap gap-1">
                    <Badge 
                      v-for="(prof, idx) in dndClass.proficiencies.slice(0, 3)" 
                      :key="idx"
                      variant="outline"
                      class="text-xs"
                    >
                      {{ prof.name }}
                    </Badge>
                    <Badge 
                      v-if="dndClass.proficiencies.length > 3"
                      variant="outline"
                      class="text-xs"
                    >
                      +{{ dndClass.proficiencies.length - 3 }}
                    </Badge>
                  </div>
                </div>

                <!-- Spellcasting -->
                <div v-if="dndClass.spellcasting" class="flex items-center gap-2">
                  <span class="text-xs text-muted-foreground">✨ Conjurador</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </Link>
      </div>

      <!-- Empty State -->
      <div v-if="!classes || classes.length === 0" class="text-center py-12">
        <p class="text-muted-foreground">Nenhuma classe encontrada</p>
      </div>
    </div>
  </AppLayout>
</template>
