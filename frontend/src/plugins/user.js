export function catchErrorMessages(errors, self){
  // FIXME: Vuei18nを使用して動的に判別したい
  errors.forEach((error) => {
    if(error.match('Name|ユーザー名')){ 
      self.errors.name.push(error)
      return
    }
    if(error.match('Introduce|自己紹介')){
      self.errors.introduce.push(error)
      return
    }
    if(error.match('Link|URL')){
      self.errors.link.push(error)
      return
    }
    if(error.match('Picture|プロフィール画像')){
      self.errors.picture.push(error)
      return
    }
    if(error.match('Cover|カバー画像')){
      self.errors.cover.push(error)
      return
    }
  })
}
