export default class {
  constructor(){
    this.items = []
  }
  set(data){
    this.items = data
  }
  insert(data){
    this.items.unshift(data)
  }
  delete(id){
    var newArray = this.items.filter(function(v){
      return v.id != id;
    })
    this.items = newArray;
  }
}
