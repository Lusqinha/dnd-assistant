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
  equipment: Array,
  filters: Object
})

const searchQuery = ref('')
const selectedCategory = ref(props.filters?.category || '')

const categories = [
  'Weapon', 'Armor', 'Adventuring Gear', 'Tools', 'Mounts and Vehicles'
]

const filteredEquipment = computed(() => {
  return props.equipment.filter(item => {
    const matchesSearch = item.name.toLowerCase().includes(searchQuery.value.toLowerCase())
    return matchesSearch
  })
})

const applyFilters = () => {
  router.get('/equipment', {
    category: selectedCategory.value
  }, {
    preserveState: true
  })
}

const getCategoryIcon = (category) => {
  const icons = {
    'Weapon': '⚔️',
    'Armor': '🛡️',
    'Adventuring Gear': '🎒',
    'Tools': '🔧',
    'Mounts and Vehicles': '🐴',
    'Wondrous Items': '✨'
  }
  return icons[category] || '📦'
}

const formatCost = (cost) => {
  if (!cost) return 'N/A'
  return `${cost.quantity} ${cost.unit}`
}
</script>

<template>
  <AppLayout title="Equipamentos">
    <div class="mx-auto max-w-7xl">
      <!-- Header -->
      <div class="mb-8">
        <h2 class="text-3xl font-bold tracking-tight">Equipamentos</h2>
        <p class="text-muted-foreground mt-2">
          Explore {{ equipment.length }} itens disponíveis
        </p>
      </div>

      <!-- Filters -->
      <Card class="mb-6">
        <CardContent class="pt-6">
          <div class="grid gap-4 sm:grid-cols-2">
            <div>
              <label class="text-sm font-medium mb-2 block">Buscar</label>
              <Input 
                v-model="searchQuery"
                placeholder="Nome do item..."
                class="w-full"
              />
            </div>
            <div>
              <label class="text-sm font-medium mb-2 block">Categoria</label>
              <Select v-model="selectedCategory" @update:model-value="applyFilters">
                <SelectTrigger>
                  <SelectValue placeholder="Todas as categorias" />
                </SelectTrigger>
                <SelectContent>
                  <SelectItem value="">Todas</SelectItem>
                  <SelectItem v-for="category in categories" :key="category" :value="category">
                    {{ category }}
                  </SelectItem>
                </SelectContent>
              </Select>
            </div>
          </div>
        </CardContent>
      </Card>

      <!-- Equipment Grid -->
      <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
        <Link
          v-for="item in filteredEquipment"
          :key="item.id"
          :href="`/equipment/${item.index}`"
          class="group"
        >
          <Card class="h-full transition-all hover:shadow-lg hover:border-primary/50">
            <CardHeader>
              <div class="flex items-start justify-between mb-2">
                <div class="text-3xl">{{ getCategoryIcon(item.gear_category) }}</div>
                <Badge v-if="item.cost" variant="secondary" class="text-xs">
                  {{ formatCost(item.cost) }}
                </Badge>
              </div>
              <CardTitle class="group-hover:text-primary transition-colors text-base">
                {{ item.name }}
              </CardTitle>
            </CardHeader>
            <CardContent>
              <div class="space-y-2">
                <div v-if="item.gear_category" class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Categoria</span>
                  <Badge variant="outline" class="text-xs">
                    {{ item.gear_category }}
                  </Badge>
                </div>
                
                <div v-if="item.weight" class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Peso</span>
                  <span class="text-xs">{{ item.weight }} lb</span>
                </div>

                <!-- Weapon specific -->
                <div v-if="item.damage" class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">Dano</span>
                  <span class="text-xs font-semibold">
                    {{ item.damage.damage_dice }} {{ item.damage.damage_type?.name }}
                  </span>
                </div>

                <!-- Armor specific -->
                <div v-if="item.armor_class" class="flex items-center justify-between text-sm">
                  <span class="text-muted-foreground">CA</span>
                  <span class="text-xs font-semibold">{{ item.armor_class.base }}</span>
                </div>
              </div>
            </CardContent>
          </Card>
        </Link>
      </div>

      <!-- Empty State -->
      <div v-if="filteredEquipment.length === 0" class="text-center py-12">
        <p class="text-muted-foreground">Nenhum item encontrado com os filtros aplicados</p>
      </div>
    </div>
  </AppLayout>
</template>
