<script setup>
import { ref, watch } from 'vue';
import { useI18n } from 'vue-i18n';

const props = defineProps({
  placeholder: {
    type: String,
    default: '',
  },
});

const emit = defineEmits(['search', 'clear']);

const { t } = useI18n();
const searchQuery = ref('');
let debounceTimer = null;

const onSearchInput = () => {
  if (debounceTimer) {
    clearTimeout(debounceTimer);
  }
  
  debounceTimer = setTimeout(() => {
    emit('search', searchQuery.value.toLowerCase().trim());
  }, 300);
};

const clearSearch = () => {
  searchQuery.value = '';
  emit('search', '');
  emit('clear');
};

watch(searchQuery, () => {
  onSearchInput();
});

defineExpose({ clearSearch, searchQuery });
</script>

<template>
  <div class="conversation-quick-search">
    <div class="search-wrap">
      <fluent-icon 
        icon="search" 
        class="search-icon"
        size="16"
      />
      <input
        v-model="searchQuery"
        type="text"
        :placeholder="placeholder || t('CHAT_LIST.QUICK_SEARCH_PLACEHOLDER')"
        class="search-input"
      />
      <fluent-icon 
        v-if="searchQuery"
        icon="dismiss"
        class="clear-icon"
        size="16"
        @click="clearSearch"
      />
    </div>
  </div>
</template>

<style scoped lang="scss">
.conversation-quick-search {
  padding: var(--space-small);
  background: var(--n-surface-0);
  border-bottom: 1px solid var(--n-slate-6);
}

.search-wrap {
  position: relative;
  display: flex;
  align-items: center;
  background: var(--n-surface-1);
  border: 1px solid var(--n-slate-6);
  border-radius: var(--border-radius-normal);
  padding: var(--space-small);
  transition: all 0.2s ease;

  &:focus-within {
    border-color: var(--n-brand);
    box-shadow: 0 0 0 3px rgba(84, 86, 255, 0.1);
  }
}

.search-icon {
  color: var(--n-slate-11);
  margin-right: var(--space-small);
  flex-shrink: 0;
}

.search-input {
  flex: 1;
  border: 0;
  background: transparent;
  font-size: var(--font-size-small);
  color: var(--n-slate-12);
  outline: none;
  min-width: 0;

  &::placeholder {
    color: var(--n-slate-10);
  }
}

.clear-icon {
  color: var(--n-slate-11);
  cursor: pointer;
  margin-left: var(--space-small);
  flex-shrink: 0;

  &:hover {
    color: var(--n-slate-12);
  }
}
</style>
