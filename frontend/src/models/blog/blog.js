export default class {
  constructor(){
    this.subject      = '';
    this.body         = '';
    this.cover_image  = '';
    this.state_number =  0;
    this.url          = '';
  }
  set(data){
    this.subject      = data.subject;
    this.body         = data.body;
    this.cover_image  = data.cover_image;
    this.state_number = data.state_value;
    this.url          = data.url;
    console.log(this)
  }
  is_valid(){
    return this.subject != false
  }
  params(){
    const params = {
      blog: {
        subject: this.subject,
        body: this.body,
        cover_image: this.cover_image,
        state_number: this.state_number
      }
    }
    return params
  }
}
