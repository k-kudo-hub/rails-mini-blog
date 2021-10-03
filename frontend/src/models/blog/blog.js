export default class {
  constructor(data = { subject: '', body: '', cover_image: { url: null, name: '' }, cover_image_name: '', state_value: 0, url: '' }){
    this.subject      = data.subject;
    this.body         = data.body;
    this.cover_image  = data.cover_image;
    this.state_number = data.state_value;
    this.cover_image_name = data.cover_image_name;
    this.url          = data.url;
  }
  set(data){
    this.subject      = data.subject;
    this.body         = data.body;
    this.cover_image  = data.cover_image_url;
    this.state_number = data.state_value;
    this.url          = data.url;
    this.updated_at   = data.format_updated_at;
    this.user_id      = data.user_id;
    this.user_name    = data.user_name;
    this.user_introduce = data.user_introduce,
    this.user_picture = data.user_picture;
  }
  is_valid(){
    return this.subject != false
  }
  params(){
    const formData = new FormData()
    formData.append('blog[subject]', this.subject)
    formData.append('blog[body]', this.body)
    formData.append('blog[state_number]', this.state_number)
    if('type' in this.cover_image){ // typeキーの存在を「新しいファイルのセット」と解釈する
      formData.append('blog[cover_image]', this.cover_image)
    } // typeキーが存在しない場合はappendしない。
    return formData
  }
}
