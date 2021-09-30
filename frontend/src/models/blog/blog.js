export default class {
  constructor(){
    this.subject      = '';
    this.body         = '';
    this.cover_image  = '';
    this.state_number =  0;
    this.url          = '';
    this.cover_image_url = '';
  }
  set(data){
    this.subject      = data.subject;
    this.body         = data.body;
    this.cover_image  = data.cover_image_url;
    this.state_number = data.state_value;
    this.url          = data.url;
    this.created_at   = data.format_created_at;
    this.user_id      = data.user_id;
    this.user_name    = data.user_name;
    this.user_introduce = data.user_introduce,
    this.user_picture = data.user_picture;
    console.log(this)
  }
  is_valid(){
    return this.subject != false
  }
  params(){
    const formData = new FormData()
    formData.append('blog[subject]', this.subject)
    formData.append('blog[body]', this.body)
    formData.append('blog[cover_image]', this.cover_image)
    formData.append('blog[state_number]', this.state_number)
    return formData
  }
}
