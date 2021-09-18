export default class {
  constructor(){
    this.content      = '';
    this.is_displayed = false;
  }
  // フラッシュメッセージ出力
  display(message){
    if(message){
      this.content = message
      this.is_displayed = true
      setTimeout(() => {
        this.is_displayed = false
      }, 2000)
    } else {
      console.log("Error: The message is not a valid value or is empty.")
    }
  }
}
