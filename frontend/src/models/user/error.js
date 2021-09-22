import Error from '../error.js'
export default class extends Error {
  constructor(){
    super()
    this.name      = [];
    this.introduce = [];
    this.link      = [];
    this.picture   = [];
    this.cover     = [];
  }
  catchErrorMessages(errors){
    // FIXME: Vuei18nを使用して動的に判別したい
    errors.forEach((error) => {
      this._push(error, 'Name|ユーザー名', this.name)
      this._push(error, 'Introduce|自己紹介', this.introduce)
      this._push(error, 'Link|URL', this.link)
      this._push(error, 'Picture|プロフィール画像', this.picture)
      this._push(error, 'Cover|カバー画像', this.cover)
    })
  }
}
