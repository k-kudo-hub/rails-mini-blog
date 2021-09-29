export default class {
  constructor(){
    this.flag      = false
    this.threshold = 25
    this.start     = { x: 0 }
    this.current   = { x: 0 }
    this.distance  = { x: 0 }
  }
  slideStart(e){
    this.flag = true;
    this.start.x = e.touches[0].pageX;
  }
  slideEnd(){
    this.flag = false;
    this.resetValues()
  }
  resetValues(){
    this.start    = { x: 0 }
    this.current  = { x: 0 }
    this.distance = { x: 0 }
  }
  slideMove(e){
    this.current.x = e.touches[0].pageX;
    this.distance.x = this.current.x - this.start.x;
    if( this.flag && ((this.distance.x < 0) && (this.distance.x <= this.threshold * -1))){
      return true
    } else {
      return false
    }
  }
}
