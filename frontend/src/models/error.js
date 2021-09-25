export default class Error {
  constructor() {
    this.common = [];
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
}
