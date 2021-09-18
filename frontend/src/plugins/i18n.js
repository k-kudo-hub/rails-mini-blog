import { createI18n } from 'vue-i18n/index'
import en_file from '../lang/en'
import ja_file from '../lang/ja'

const messages = {
  en: en_file,
  ja: ja_file
}

const i18n = createI18n({
  locale: 'ja',
  messages,
})

export default i18n;
