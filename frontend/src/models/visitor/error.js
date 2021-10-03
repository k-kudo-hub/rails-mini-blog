import Error from '../error.js'
export default class extends Error {
  constructor(){
    super()
    this.name      = [];
    this.email     = [];
    this.password  = [];
  }
  catchErrorMessages(errors){
    // FIXME: Vuei18nを使用して動的に判別したい
    errors.forEach((error) => {
      this._push(error, 'Name|ユーザー名', this.name)
      this._push(error, 'Email|メールアドレス', this.email)
      this._push(error, 'Password|パスワード', this.password)
    })
  }
}
