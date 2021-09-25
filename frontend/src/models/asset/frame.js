export default class {
  constructor(){
    this.is_frame_emphasize = false;
  }
  startEmphasize(){
    console.log("set")
    if(!this.is_frame_emphasized){ this.is_frame_emphasized = true };
  }
  stopEmphasize(){
    console.log("out")
    if(this.is_frame_emphasized){ this.is_frame_emphasized = false };
  }
  emphasize(){
    return this.is_frame_emphasized ? "bg-yellow-100" : "";
  }
}
