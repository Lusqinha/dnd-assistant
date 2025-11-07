<script setup>
import { Link, router } from '@inertiajs/vue3'
import { ref, computed } from 'vue'
import AppLayout from '@/layouts/AppLayout.vue'
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card'
import { Badge } from '@/components/ui/badge'
import { Input } from '@/components/ui/input'
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select'

const props = defineProps({
  monsters: Array,
  filters: Object
})

const searchQuery = ref('')
const selectedType = ref(props.filters?.type || '')
const selectedCR = ref(props.filters?.cr || '')

const monsterTypes = [
  'aberration', 'beast', 'celestial', 'construct', 'dragon', 'elemental',
  'fey', 'fiend', 'giant', 'humanoid', 'monstrosity', 'ooze', 'plant', 'undead'
]

const filteredMonsters = computed(() => {
  return props.monsters.filter(monster => {
    const matchesSearch = monster.name.toLowerCase().includes(searchQuery.value.toLowerCase())
    return matchesSearch
  })
})

const applyFilters = () => {
  router.get('/monsters', {
    type: selectedType.value,
    cr: selectedCR.value
  }, {
    preserveState: true
  })
}

const getTypeIcon = (type) => {
  const icons = {
    'aberration': '👁️',
    'beast': '🐺',
    'celestial': '👼',
    'construct': '🤖',
    'dragon': '🐉',
    'elemental': '🌪️',
    'fey': '🧚',
    'fiend': '😈',
    'giant': '🗿',
    'humanoid': '👤',
    'monstrosity': '🦑',
    'ooze': '💧',
    'plant': '🌿',
    'undead': '💀'
  }
  return icons[type] || '👾'
}

const getCRColor = (cr) => {
  if (cr === null || cr === undefined) return 'secondary'
  const crNum = parseFloat(cr)
  if (crNum < 1) return 'secondary'
  if (crNum < 5) return 'default'
  if (crNum < 10) return 'destructive'
  return 'destructive'
}
</script>

<template>
  <AppLayout title="Monstros">
    <div class="mx-auto max-w-7xl">
      <!-- Header -->
      <div class="mb-8">
        <h2 class="text-3xl font-bold tracking-tight">Bestiário</h2>
        <p class="text-muted-foreground mt-2">
          Explore {{ monsters.length }} criaturas do D&D 5e
        </p>
      </div>

      <!-- Filters -->
      <Card class="mb-6">
        <CardContent class="pt-6">
          <div class="grid gap-4 sm:grid-cols-3">
            <div>
              <label class="text-sm font-medium mb-2 block">Buscar</label>
              <Input 
                v-model="searchQuery"
                placeholder="Nome do monstro..."
                class="w-full"
              />
            </div>
            <div>
              <label class="text-sm font-medium mb-2 block">Tipo</label>
              <Select v-model="selectedType" @update:model-value="applyFilters">
                <SelectTrigger>
                  <SelectValue placeholder="Todos os tipos" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="">Todos</SelectItem>
                  <SelectItem v-for="type in monsterTypes" :key="type" :value="type">
                    {{ type.charAt(0).toUpperCase() + type.slice(1) }}
                  </SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <label class="text-sm font-medium mb-2 block">Challenge Rating</label>
              <Select v-model="selectedCR" @update:model-value="applyFilters">
                <SelectTrigger>
                  <SelectValue placeholder="Todos os CRs" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="">Todos</SelectItem>
                  <SelectItem value="0">CR 0</SelectItem>
                  <SelectItem value="0.125">CR 1/8</SelectItem>
                  <SelectItem value="0.25">CR 1/4</SelectItem>
                  <SelectItem value="0.5">CR 1/2</SelectItem>
                  <SelectItem v-for="n in 30" :key="n" :value="n.toString()">
                    CR {{ n }}
                  </SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
        </CardContent>
      </Card>

      <!-- Monsters Grid -->
      <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        <Link
          v-for="monster in filteredMonsters"
          :key="monster.id"
          :href="`/monsters/${monster.index}`"
          class="group"
        >
          <Card class="h-full transition-all hover:shadow-lg hover:border-primary/50">
            <CardHeader>
              <div class="flex items-start justify-between mb-2">
                <div class="text-3xl">{{ getTypeIcon(monster.type) }}</div>
                <Badge :variant="getCRColor(monster.challenge_rating)">
                  CR {{ monster.challenge_rating }}
                </Badge>
              </div>
              <CardTitle class="group-hover:text-primary transition-colors text-base">
                {{ monster.name }}
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div class="space-y-2">
                <div class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Tipo</span>
                  <Badge variant="outline" class="text-xs capitalize">
                    {{ monster.type }}
                  </Badge>
                </div>
                
                <div class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Tamanho</span>
                  <span class="text-xs capitalize">{{ monster.size }}</span>
                </div>

                <div class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">CA</span>
                  <span class="text-xs font-semibold">{{ monster.armor_class }}</span>
                </div>

                <div class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">PV</span>
                  <span class="text-xs font-semibold">{{ monster.hit_points }}</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </Link>
      </div>

      <!-- Empty State -->
      <div v-if="filteredMonsters.length === 0" class="text-center py-12">
        <p class="text-muted-foreground">Nenhum monstro encontrado com os filtros aplicados</p>
      </div>
    </div>
  </AppLayout>
</template>
