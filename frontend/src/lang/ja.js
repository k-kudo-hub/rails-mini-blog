const messages = Object.freeze({
  form: {
    cancel_message: 'キャンセルしますか？変更は保存されません。',
    delete_message: 'を削除しようとしています。本当によろしいですか？',
    drag_and_drop: 'またはここにドラッグ&ドロップ',
    not_selected: '未選択',
    success: 'が成功しました。',
    blog: {
      body_placeholder: '自由にブログを書いてみましょう。\nマークダウンに対応しています。'
    },
    starred: 'ブログをスターしました。',
    delete_star: 'スターを取り消しました。'
  },
  button: {
    cancel: 'キャンセル',
    updating: '更新する',
    uploading: 'アップロードする',
    save: '保存',
    saving: '保存する',
  },
  errors: {
    character_20: '20文字以内',
    character_50: '50文字以内',
    character_8_password: '8文字以上・英数字混合',
    is_empty: 'が空です。',
    require: '必須',
    require_input: 'を入力してください。',
    require_select: 'を選択して下さい。',
    wrong_message: 'メールアドレスかパスワードが間違っています。',
    no_posts_message: 'まだ投稿はありません。',
    can_not_star: 'このブログはスターできません。'
  },
  action: {
    create: '作成',
    edit: '編集',
    index: '一覧',
    manage: '管理',
    update: '更新',
    upload: 'アップロード',
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
  },
  star: {
    options: {
      latest: '最新',
      stars: 'スター済み',
      higher_rating: '高評価'
    }
  },
  asset: {
    file: "ファイル",
    alt: '代替テキスト',
  },
  common: {
    updated_at: '最終更新日',
  }
})

export default messages
