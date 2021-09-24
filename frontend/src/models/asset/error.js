import Error from '../error.js'
export default class extends Error {
  constructor(){
    super()
    this.file = [];
    this.alt  = [];
  }
  catch(errors){
    // FIXME: Vuei18nを使用して動的に判別したい
    errors.forEach((error) => {
      this._push(error, 'File|ファイル', this.file)
      this._push(error, 'Alt|代替テキスト', this.alt)
    })
  }
}
