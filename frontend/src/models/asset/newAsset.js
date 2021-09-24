import Asset from './asset.js'
export default class extends Asset {
  constructor() {
    super()
  }
  set(file){
    this.file = file;
  }
}
