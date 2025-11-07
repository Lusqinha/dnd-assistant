<script setup>
import { Link } from '@inertiajs/vue3'
import AppLayout from '@/layouts/AppLayout.vue'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Button } from '@/components/ui/button'
import { ArrowLeft } from 'lucide-vue-next'

const props = defineProps({
  dndClass: Object
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
  <AppLayout :title="dndClass.name">
    <div class="mx-auto max-w-5xl">
      <!-- Back Button -->
      <Link href="/classes" class="inline-flex items-center gap-2 text-sm text-muted-foreground hover:text-foreground mb-6">
        <ArrowLeft class="h-4 w-4" />
        Voltar para Classes
      </Link>

      <!-- Header Card -->
      <Card class="mb-6">
        <CardHeader>
          <div class="flex items-start justify-between">
            <div class="flex items-center gap-4">
              <div class="text-6xl">{{ getClassIcon(dndClass.name) }}</div>
              <div>
                <CardTitle class="text-4xl mb-2">{{ dndClass.name }}</CardTitle>
                <div class="flex gap-2">
                  <Badge variant="secondary">Dado de Vida: d{{ dndClass.hit_die }}</Badge>
                  <Badge v-if="dndClass.spellcasting" variant="outline">✨ Conjurador</Badge>
                </div>
              </div>
            </div>
          </div>
        </CardHeader>
      </Card>

      <!-- Main Content Grid -->
      <div class="grid gap-6 md:grid-cols-2">
        <!-- Proficiências -->
        <Card>
          <CardHeader>
            <CardTitle>Proficiências</CardTitle>
          </CardHeader>
          <CardContent class="space-y-4">
            <!-- Proficiências Básicas -->
            <div v-if="dndClass.proficiencies && dndClass.proficiencies.length > 0">
              <h4 class="text-sm font-semibold mb-2">Proficiências Iniciais</h4>
              <div class="flex flex-wrap gap-2">
                <Badge 
                  v-for="(prof, idx) in dndClass.proficiencies" 
                  :key="idx"
                  variant="outline"
                >
                  {{ prof.name }}
                </Badge>
              </div>
            </div>

            <!-- Escolhas de Proficiências -->
            <div v-if="dndClass.proficiency_choices && dndClass.proficiency_choices.length > 0">
              <h4 class="text-sm font-semibold mb-2">Escolha de Proficiências</h4>
              <div v-for="(choice, idx) in dndClass.proficiency_choices" :key="idx" class="mb-3">
                <p class="text-sm text-muted-foreground mb-1">
                  Escolha {{ choice.choose }} de:
                </p>
                <div class="flex flex-wrap gap-2">
                  <Badge 
                    v-for="(opt, optIdx) in choice.from" 
                    :key="optIdx"
                    variant="secondary"
                  >
                    {{ opt.name }}
                  </Badge>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>

        <!-- Testes de Resistência -->
        <Card>
          <CardHeader>
            <CardTitle>Testes de Resistência</CardTitle>
          </CardHeader>
          <CardContent>
            <div v-if="dndClass.saving_throws && dndClass.saving_throws.length > 0">
              <div class="flex flex-wrap gap-2">
                <Badge 
                  v-for="(save, idx) in dndClass.saving_throws" 
                  :key="idx"
                  variant="default"
                  class="text-sm"
                >
                  {{ save.name }}
                </Badge>
              </div>
            </div>
            <p v-else class="text-sm text-muted-foreground">Nenhum teste de resistência especificado</p>
          </CardContent>
        </Card>

        <!-- Equipamento Inicial -->
        <Card class="md:col-span-2">
          <CardHeader>
            <CardTitle>Equipamento Inicial</CardTitle>
          </CardHeader>
          <CardContent>
            <div v-if="dndClass.starting_equipment && dndClass.starting_equipment.length > 0" class="space-y-2">
              <div 
                v-for="(item, idx) in dndClass.starting_equipment" 
                :key="idx"
                class="flex items-center gap-2 text-sm"
              >
                <span class="text-muted-foreground">•</span>
                <span>{{ item.quantity }}x {{ item.equipment?.name || 'Item' }}</span>
              </div>
            </div>
            <p v-else class="text-sm text-muted-foreground">Nenhum equipamento inicial especificado</p>
          </CardContent>
        </Card>

        <!-- Subclasses -->
        <Card v-if="dndClass.subclasses && dndClass.subclasses.length > 0" class="md:col-span-2">
          <CardHeader>
            <CardTitle>Subclasses</CardTitle>
          </CardHeader>
          <CardContent>
            <div class="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
              <div 
                v-for="(subclass, idx) in dndClass.subclasses" 
                :key="idx"
                class="rounded-lg border border-border p-3 hover:bg-accent/50 transition-colors"
              >
                <p class="font-medium">{{ subclass.name }}</p>
              </div>
            </div>
          </CardContent>
        </Card>

        <!-- Spellcasting -->
        <Card v-if="dndClass.spellcasting" class="md:col-span-2">
          <CardHeader>
            <CardTitle>Conjuração</CardTitle>
          </CardHeader>
          <CardContent>
            <div class="space-y-3">
              <div v-if="dndClass.spellcasting.level">
                <p class="text-sm text-muted-foreground">Nível para Conjuração:</p>
                <p class="text-lg font-semibold">{{ dndClass.spellcasting.level }}</p>
              </div>
              <div v-if="dndClass.spellcasting.spellcasting_ability">
                <p class="text-sm text-muted-foreground">Atributo de Conjuração:</p>
                <Badge variant="default">{{ dndClass.spellcasting.spellcasting_ability.name }}</Badge>
              </div>
              <div v-if="dndClass.spellcasting.info && dndClass.spellcasting.info.length > 0">
                <p class="text-sm text-muted-foreground mb-2">Informações:</p>
                <div class="space-y-2">
                  <div 
                    v-for="(info, idx) in dndClass.spellcasting.info" 
                    :key="idx"
                    class="text-sm"
                  >
                    <p class="font-medium">{{ info.name }}</p>
                    <p class="text-muted-foreground" v-for="(desc, descIdx) in info.desc" :key="descIdx">
                      {{ desc }}
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </CardContent>
        </Card>
      </div>
    </div>
  </AppLayout>
</template>
