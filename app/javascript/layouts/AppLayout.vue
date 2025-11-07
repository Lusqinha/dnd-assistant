<script setup>
import { Link } from '@inertiajs/vue3'
import { ref, onMounted } from 'vue'
import { useDarkMode } from '@/composables/useDarkMode'
import { 
  BookOpen, 
  Sword, 
  Sparkles, 
  Users, 
  Shield,
  Menu,
  X,
  Moon,
  Sun
} from 'lucide-vue-next'

const props = defineProps({
  title: String
})

const sidebarOpen = ref(true)
const { isDark, toggleDarkMode, initializeTheme } = useDarkMode()

onMounted(() => {
  initializeTheme()
})

const menuItems = [
  { name: 'Classes', icon: BookOpen, href: '/classes', description: 'Classes de personagens' },
  { name: 'Raças', icon: Users, href: '/races', description: 'Raças jogáveis' },
  { name: 'Equipamentos', icon: Sword, href: '/equipment', description: 'Armas, armaduras e itens' },
  { name: 'Magias', icon: Sparkles, href: '/spells', description: 'Feitiços e encantamentos' },
  { name: 'Monstros', icon: Shield, href: '/monsters', description: 'Bestiário completo' },
]
</script>

<template>
  <div class="min-h-screen bg-background">
    <!-- Sidebar -->
    <aside 
      :class="[
        'fixed inset-y-0 left-0 z-50 w-64 transform transition-transform duration-200 ease-in-out',
        'bg-card border-r border-border',
        sidebarOpen ? 'translate-x-0' : '-translate-x-full'
      ]"
    >
      <div class="flex h-full flex-col">
        <!-- Header -->
        <div class="flex h-16 items-center justify-between border-b border-border px-6">
          <Link href="/" class="flex items-center gap-2">
            <span class="text-2xl">🎲</span>
            <span class="text-lg font-semibold">D&D Assistant</span>
          </Link>
          <button 
            @click="sidebarOpen = false"
            class="lg:hidden text-muted-foreground hover:text-foreground"
          >
            <X class="h-5 w-5" />
          </button>
        </div>

        <!-- Navigation -->
        <nav class="flex-1 space-y-1 p-4">
          <Link
            v-for="item in menuItems"
            :key="item.name"
            :href="item.href"
            class="group flex items-center gap-3 rounded-lg px-3 py-2 text-sm font-medium transition-colors hover:bg-accent hover:text-accent-foreground"
          >
            <component :is="item.icon" class="h-5 w-5 text-muted-foreground group-hover:text-accent-foreground" />
            <div class="flex flex-col">
              <span>{{ item.name }}</span>
              <span class="text-xs text-muted-foreground">{{ item.description }}</span>
            </div>
          </Link>
        </nav>

        <!-- Footer -->
        <div class="border-t border-border p-4">
          <div class="text-xs text-muted-foreground">
            <p class="font-semibold mb-1">D&D 5e SRD</p>
            <p>Sistema de Referência</p>
          </div>
        </div>
      </div>
    </aside>

    <!-- Main Content -->
    <div :class="['transition-all duration-200', sidebarOpen ? 'lg:pl-64' : '']">
      <!-- Top Bar -->
      <header class="sticky top-0 z-40 flex h-16 items-center gap-4 border-b border-border bg-background px-6">
        <button 
          @click="sidebarOpen = !sidebarOpen"
          class="text-muted-foreground hover:text-foreground"
        >
          <Menu class="h-5 w-5" />
        </button>
        <div class="flex-1">
          <h1 class="text-lg font-semibold">{{ title }}</h1>
        </div>
        <!-- Dark Mode Toggle -->
        <button
          @click="toggleDarkMode"
          class="rounded-lg p-2 text-muted-foreground hover:bg-accent hover:text-accent-foreground transition-colors"
          :title="isDark ? 'Modo Claro' : 'Modo Escuro'"
        >
          <Sun v-if="isDark" class="h-5 w-5" />
          <Moon v-else class="h-5 w-5" />
        </button>
      </header>

      <!-- Page Content -->
      <main class="p-6">
        <slot />
      </main>
    </div>
  </div>
</template>
