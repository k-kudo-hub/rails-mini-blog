const messages = Object.freeze({
  form: {
    cancel_message: 'Would you like to cancel? Changes are not saved.',
    delete_message: ' will be deleted by you. Are you sure that?',
    drag_and_drop: 'or drag and drop here',
    not_selected: 'Unselected',   
    success: 'was successful.',
    blog: {
      body_placeholder: 'Feel free to write a blog!\nSupports markdown notation'
    },
    starred: 'Highly appreciated.',
    delete_star: 'Withdrew high praise.'
  },
  button: {
    cancel: 'Cancel ',
    updating: 'Update ',
    uploading: 'Upload',
    save: 'Save ',
    saving: 'Save',
  },
  errors: {
    character_20: '20 characters or less',
    character_50: '50 characters or less',
    character_8_password: '8 characters or more. Must use Alphabets and numbers',
    is_empty: 'is empty.',
    require: 'required',
    require_input: " can't be blank.",
    require_select: ' is not selected.',
    wrong_message: 'Wrong email address or password.',
    no_posts_message: 'No posts yet.',
    can_not_star: 'This blog can not star',
  },
  action: {
    create: 'Create ',
    edit: 'Edit ',
    index: 'List',
    manage: 'manage',
    update: 'Update ',
    upload: 'Upload ',
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
  star: {
    options: {
      latest: 'Latest',
      stars: 'Liked',
      higher_rating: 'High rating'
    }
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
    },
  },
  common: {
    updated_at: 'Updated at ',
  }
})

export default messages
