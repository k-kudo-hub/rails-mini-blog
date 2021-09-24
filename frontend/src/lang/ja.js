const messages = Object.freeze({
  form: {
    cancel: 'キャンセル',
    cancel_message: 'キャンセルしますか？変更は保存されません。',
    character_20: '20文字以内',
    character_50: '50文字以内',
    character_8_password: '8文字以上・英数字混合',
    create: '作成',
    edit: '編集',
    require: '必須',
    require_message: 'を入力してください。',
    save: '保存',
    saving: '保存する',
    success: 'が成功しました。',
    update: '更新',
    updating: '更新する',
    upload: 'アップロード',
    uploading: 'アップロードする',
    wrong_message: 'メールアドレスかパスワードが間違っています。'
  },
  action: {
    manage: '管理'
  },
  link: {
    blog: 'ブログ',
    trend: 'トレンド',
    star: 'スター',
    account: 'マイページ'
  },
  profile: {
    profile: 'プロフィール',
    blogs: '記事一覧',
    follow: 'フォロー',
    follower: 'フォロワー',
  },
  session: {
    sign_up: '新規登録',
    sign_in: 'ログイン',
    sign_out: 'ログアウト',
    registration: '登録',
  },
  models: {
    user: 'ユーザー',
    blog: 'ブログ',
    asset: '素材'
  },
  user: {
    name: 'ユーザー名',
    email: 'メールアドレス',
    password: 'パスワード',
    introduce: '自己紹介',
    cover: 'カバー画像',
    picture: 'プロフィール画像',
    link: 'URL'
  },
  blog: {
    subject: 'タイトル',
    body: '本文',
    cover_image: 'カバー画像',
    state_number: '公開状態',
    options: {
      draft: '下書き',
      limited: '限定公開',
      release: '公開'
    },
    url: 'URL',
    markdown: {
      editor: 'エディタ',
      preview: 'プレビュー'
    },
  }
})

export default messages
