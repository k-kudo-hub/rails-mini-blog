export default class {
  constructor(){
    this.name     = '';
    this.password = '';
    this.email    = '';
  }

  is_valid_for_login(){
    return this.email && this.password
  }

  is_valid_for_registration(){
    return this.email && this.password && this.name
  }

  to_param_for_login(){
    const formData = new FormData()
    formData.append('session[email]', this.email)
    formData.append('session[password]', this.password)
    return formData
  }

  to_param_for_registration(){
    const formData = new FormData()
    formData.append('user[name]', this.name)
    formData.append('user[email]', this.email)
    formData.append('user[password]', this.password)
    return formData
  }
}
