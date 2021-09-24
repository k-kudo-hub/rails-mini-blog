export default class {
  constructor(){
    this.is_asset_open   = false;
    this.is_edit_open    = false;
    this.is_picture_open = false;
    this.is_cover_open   = false;
  }
  toggleAsset(){
    this.is_asset_open ? this.is_asset_open = false : this.is_asset_open = true;
  }
  toggleEdit(){
    this.is_edit_open ? this.is_edit_open = false : this.is_edit_open = true;
  }
  togglePicture(){
    this.is_picture_open ? this.is_picture_open = false : this.is_picture_open = true;
  }
  toggleCover(){
    this.is_cover_open ? this.is_cover_open = false : this.is_cover_open = true;
  }
  is_open(){
    return this.is_asset_open || this.is_edit_open || this.is_picture_open || this.is_cover_open
  }
}
