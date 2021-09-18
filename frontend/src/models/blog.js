export default class {
  constructor(){
    this.subject      = '';
    this.body         = '';
    this.cover_image  = '';
    this.state_number = '';
    this.url          = '';
  }
  set(data){
    this.subject      = data.subject;
    this.body         = data.body;
    this.cover_image  = data.cover_image;
    this.state_number = data.state_number;
    this.url          = data.url;
  }
}
