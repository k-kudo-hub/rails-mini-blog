export default class {
  constructor(){
    this.id          = 0;
    this.name        = '';
    this.introduce   = '';
    this.picture     = '';
    this.picture_url = '';
    this.cover       = '';
    this.cover_url   = '';
    this.link        = '';
  }
  setData(data){
    this.id          = data.id;
    this.name        = data.name;
    this.introduce   = data.introduce;
    this.picture     = data.picture;
    this.picture_url = data.picture_url;
    this.cover       = data.cover;
    this.cover_url   = data.cover_url;
    this.link        = data.link;
  }
  setInfo(data){
    this.name        = data.name;
    this.introduce   = data.introduce;
    this.link        = data.link;
  }
  setPicture(data){
    this.picture_url = data
  }
  setCover(data){
    this.cover_url   = data
  }
}
