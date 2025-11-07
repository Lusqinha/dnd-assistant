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
  spells: Array,
  filters: Object
})

const searchQuery = ref('')
const selectedLevel = ref(props.filters?.level || '')
const selectedSchool = ref(props.filters?.school || '')

const schools = [
  'Abjuration', 'Conjuration', 'Divination', 'Enchantment',
  'Evocation', 'Illusion', 'Necromancy', 'Transmutation'
]

const filteredSpells = computed(() => {
  return props.spells.filter(spell => {
    const matchesSearch = spell.name.toLowerCase().includes(searchQuery.value.toLowerCase())
    return matchesSearch
  })
})

const applyFilters = () => {
  router.get('/spells', {
    level: selectedLevel.value,
    school: selectedSchool.value
  }, {
    preserveState: true
  })
}

const getSchoolIcon = (school) => {
  const icons = {
    'Abjuration': '🛡️',
    'Conjuration': '🌀',
    'Divination': '🔮',
    'Enchantment': '✨',
    'Evocation': '⚡',
    'Illusion': '🎭',
    'Necromancy': '💀',
    'Transmutation': '🔄'
  }
  return icons[school] || '📜'
}

const getLevelText = (level) => {
  if (level === 0) return 'Truque'
  return `Nível ${level}`
}
</script>

<template>
  <AppLayout title="Magias">
    <div class="mx-auto max-w-7xl">
      <!-- Header -->
      <div class="mb-8">
        <h2 class="text-3xl font-bold tracking-tight">Grimório de Magias</h2>
        <p class="text-muted-foreground mt-2">
          Explore {{ spells.length }} magias do D&D 5e
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
                placeholder="Nome da magia..."
                class="w-full"
              />
            </div>
            <div>
              <label class="text-sm font-medium mb-2 block">Nível</label>
              <Select v-model="selectedLevel" @update:model-value="applyFilters">
                <SelectTrigger>
                  <SelectValue placeholder="Todos os níveis" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="">Todos</SelectItem>
                  <SelectItem value="0">Truques</SelectItem>
                  <SelectItem v-for="n in 9" :key="n" :value="n.toString()">
                    Nível {{ n }}
                  </SelectItem>
                </SelectContent>
              </Select>
            </div>
            <div>
              <label class="text-sm font-medium mb-2 block">Escola</label>
              <Select v-model="selectedSchool" @update:model-value="applyFilters">
                <SelectTrigger>
                  <SelectValue placeholder="Todas as escolas" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="">Todas</SelectItem>
                  <SelectItem v-for="school in schools" :key="school" :value="school">
                    {{ school }}
                  </SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
        </CardContent>
      </Card>

      <!-- Spells Grid -->
      <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        <Link
          v-for="spell in filteredSpells"
          :key="spell.id"
          :href="`/spells/${spell.index}`"
          class="group"
        >
          <Card class="h-full transition-all hover:shadow-lg hover:border-primary/50">
            <CardHeader>
              <div class="flex items-start justify-between mb-2">
                <div class="text-3xl">{{ getSchoolIcon(spell.school?.name) }}</div>
                <Badge :variant="spell.level === 0 ? 'secondary' : 'default'">
                  {{ getLevelText(spell.level) }}
                </Badge>
              </div>
              <CardTitle class="group-hover:text-primary transition-colors text-lg">
                {{ spell.name }}
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div class="space-y-2">
                <div class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Escola</span>
                  <Badge variant="outline" class="text-xs">
                    {{ spell.school?.name }}
                  </Badge>
                </div>
                
                <div class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Tempo</span>
                  <span class="text-xs">{{ spell.casting_time }}</span>
                </div>

                <div class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Alcance</span>
                  <span class="text-xs">{{ spell.range }}</span>
                </div>

                <div v-if="spell.concentration" class="flex items-center gap-1 text-xs text-muted-foreground">
                  <span>🎯</span>
                  <span>Concentração</span>
                </div>

                <div v-if="spell.ritual" class="flex items-center gap-1 text-xs text-muted-foreground">
                  <span>📿</span>
                  <span>Ritual</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </Link>
      </div>

      <!-- Empty State -->
      <div v-if="filteredSpells.length === 0" class="text-center py-12">
        <p class="text-muted-foreground">Nenhuma magia encontrada com os filtros aplicados</p>
      </div>
    </div>
  </AppLayout>
</template>
