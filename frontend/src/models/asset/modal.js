export default class {
  constructor(){
    this.is_asset_open = false;
  }
  toggle(){
    this.is_asset_open ? this.is_asset_open = false : this.is_asset_open = true;
  }
  is_open(){
    return this.is_asset_open
  }
}
