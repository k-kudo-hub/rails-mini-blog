function catchErrorMessages(errors, self){
  // FIXME: Vuei18nを使用して動的に判別したい
  errors.forEach((error) => {
    if(error.match('Name | ユーザー名')){ 
      self.errors.name.push(error)
      return
    }
    if(error.match('Introduce | 自己紹介')){
      self.errors.introduce.push(error)
      return
    }
    if(error.match('Link | URL')){
      self.errors.link.push(error)
      return
    }
    if(error.match('Picture | プロフィール画像')){
      self.errors.picture.push(error)
      return
    }
    if(error.match('Cover | カバー画像')){
      self.errors.cover.push(error)
      return
    }
  })
}

function resetErrors(self){
  // FIXME: 初期化する関数に置き換えたい
  self.errors = { name: [], introduce: [], link: [], picture: [], cover: [] }
}

export default {
  catchErrorMessages,
  resetErrors,
}
