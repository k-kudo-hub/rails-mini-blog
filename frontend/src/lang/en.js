const messages = Object.freeze({
  form: {
    cancel: 'Cancel ',
    cancel_message: 'Would you like to cancel? Changes are not saved.',
    create: 'Create ',
    drag_and_drop: 'or drag and drop here',
    edit: 'Edit ',
    index: 'List',
    not_selected: 'Unselected',
    save: 'Save ',
    saving: 'Save',
    success: 'was successful.',
    update: 'Update ',
    updating: 'Update ',
    upload: 'Upload ',
    uploading: 'Upload',
  },
  errors: {
    character_20: '20 characters or less',
    character_50: '50 characters or less',
    character_8_password: '8 characters or more. Must use Alphabets and numbers',
    is_empty: 'is empty.',
    require: 'required',
    require_input: " can't be blank.",
    require_select: ' is not selected.',
    wrong_message: 'Wrong email address or password.'
  },
  action: {
    manage: 'manage'
  },
  link: {
    blog: 'blogs',
    trend: 'trend',
    star: 'stars',
    account: 'my page'
  },
  profile: {
    profile: 'Profile ',
    blogs: 'Blogs ',
    follow: 'following ',
    follower: 'follower ',
  },
  session: {
    sign_up: 'Sign up',
    sign_in: 'Sign in',
    sign_out: 'Sign out',
    registration: 'registration',
  },
  models: {
    user: 'User ',
    blog: 'Blog ',
    asset: 'Asset '
  },
  user: {
    name: 'Name ',
    email: 'Email ',
    password: 'Password ',
    introduce: 'Self introduce ',
    cover: 'Cover image ',
    picture: 'Profile image ',
    link: 'URL '
  },
  blog: {
    subject: 'Subject ',
    body: 'body',
    cover_image: 'Cover image',
    state_number: 'State number',
    options: {
      draft: 'Draft',
      limited: 'Limited',
      release: 'Release'
    },
    url: 'URL',
    markdown: {
      editor: 'Editor',
      preview: 'Preview'
    },
    asset: {
      file: "File ",
      alt: 'Alternative ',
    }
  }
})

export default messages
