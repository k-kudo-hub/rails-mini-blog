export default class {
  constructor(){
    this.subject      = [];
    this.body         = [];
    this.cover_image  = [];
    this.state_number = [];
  }
  _push(error, pattern, target){
    if(error.match(pattern)){ 
      target.push(error)
      return
    }
  }
  inputValidation(target, message){
    target.push(message)
  }
  catchErrorMessages(errors){
    // FIXME: Vuei18nを使用して動的に判別したい
    errors.forEach((error) => {
      this._push(error, 'Subject|タイトル', this.subject)
      this._push(error, 'Body|本文', this.body)
      this._push(error, 'CoverImage|カバー画像', this.cover_image)
      this._push(error, 'StateNumber|公開状態', this.state_number)
    })
  }
}
