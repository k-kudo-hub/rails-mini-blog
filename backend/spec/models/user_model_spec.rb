require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  # bundle exec rspec spec/models/user_model_spec.rb

  describe 'User registration' do
    context 'Registration is successful' do
      it 'If Name, Email, Password exist, you can register.' do
        expect(@user).to be_valid
      end

      it 'You can register even if Picture is blank' do
        @user.picture = ''
        expect(@user).to be_valid
      end

      it 'You can register even if Cover is blank' do
        @user.cover = ''
        expect(@user).to be_valid
      end

      it 'You can register even if Introduce is blank' do
        @user.introduce = ''
        expect(@user).to be_valid
      end

      it 'You can register even if Provider is blank' do
        @user.provider = ''
        expect(@user).to be_valid
      end

      it 'You can register even if uid is blank' do
        @user.uid = ''
        expect(@user).to be_valid
      end
    end

    context 'Registration does not work' do
      it 'If Name is blank, you cannot register' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ユーザー名を入力してください')
      end

      it 'If Email is blank, you cannot register' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスを入力してください')
      end

      it 'If Password is blank, you cannot register' do
        @user.password_digest = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'If Name is 21 characters or more, it cannot be registered.' do
        @user.name = 'abcdefghijklmnopqrstu'
        @user.valid?
        expect(@user.errors.full_messages).to include('ユーザー名は20文字以内で入力してください')
      end

      it 'If Password is less than 8 characters, you cannot register.' do
        @user.password = 'abcde11'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは8文字以上の半角英数字混合で登録できます。')
      end

      it 'If Password does not contain numbers, you cannot register.' do
        @user.password = 'abcdefgh'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは8文字以上の半角英数字混合で登録できます。')
      end

      it 'If Password does not contain letters, you cannot register.' do
        @user.password = '12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは8文字以上の半角英数字混合で登録できます。')
      end

      it 'If A does not contain "@", you cannot register.' do
        @user.email = 'abc.example.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end

      it 'If @ in the email is at the beginning or end, you cannot register.' do
        @user.email = 'abc.example.com@'
        @user.valid?
        expect(@user.errors.full_messages).to include('メールアドレスは不正な値です')
      end

      it 'If Email has already been used, it cannot be registered..' do
        @user.save
        user2 = FactoryBot.build(:user, email: @user.email)
        user2.valid?
        expect(user2.errors.full_messages).to include('メールアドレスはすでに存在します')
      end
    end
  end

  describe 'User profile information update' do
    before do
      @user.save
    end

    context 'Update is successfull' do
      it 'If Name exists, it can be registered.' do
        @user.name = 'Bob'
        @user.valid?(:update_profile_validation)
        expect(@user).to be_valid
      end

      it 'You can update even if Introduce is blank' do
        @user.introduce = ''
        @user.valid?(:update_profile_validation)
        expect(@user).to be_valid
      end

      it 'You can update even if Link is blank' do
        @user.link = ''
        @user.valid?(:update_profile_validation)
        expect(@user).to be_valid
      end

      it 'If the beginning of link is "http", you can update.' do
        @user.link = 'http://localhost:8080/'
        @user.valid?(:update_profile_validation)
        expect(@user).to be_valid
      end

      it 'If the beginning of link is "https", you can update.' do
        @user.link = 'https://localhost:8080/'
        @user.valid?(:update_profile_validation)
        expect(@user).to be_valid
      end
    end

    context 'Update does not work' do
      it 'Cannot be updated if Name is blank' do
        @user.name = ''
        @user.valid?(:update_profile_validation)
        expect(@user.errors.full_messages).to include('ユーザー名を入力してください')
      end

      it 'If the Name is 21 characters or more, it cannot be updated.' do
        @user.name = 'a' * 21
        @user.valid?(:update_profile_validation)
        expect(@user.errors.full_messages).to include('ユーザー名は20文字以内で入力してください')
      end

      it 'Cannot register if i is 251 characters or more' do
        @user.introduce = 'a' * 251
        @user.valid?(:update_profile_validation)
        expect(@user.errors.full_messages).to include('自己紹介は250文字以内で入力してください')
      end

      it 'cannot be updated if the beginning of link is not http or https.' do
        @user.link = 'www.example.com'
        @user.valid?(:update_profile_validation)
        expect(@user.errors.full_messages).to include('URLはhttpまたはhttpsを先頭にしてください。')
      end
    end
  end

  describe 'User profile picture update' do
    before do
      @user.save
    end

    context 'Update is successfull' do
      it 'If an picture is selected, you can register it.' do
        @user.picture = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/assets/images/git-logo-fire.png'))
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context 'Update does not work' do
      it 'cannot be updated if the extension of the image is svg.' do
        @user.picture = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/assets/images/vue.svg'))
        @user.valid?
        expect(@user.errors.full_messages).to include('プロフィール画像"svg"ファイルのアップロードは許可されていません。アップロードできるファイルタイプ: jpg, png')
      end
    end
  end

  describe 'User profile cover update' do
    before do
      @user.save
    end

    context 'Update is successfull' do
      it 'cannot be updated if the extension of the image is svg.' do
        @user.cover = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/assets/images/git-logo-fire.png'))
        @user.valid?
        expect(@user).to be_valid
      end
    end

    context 'Update does not work' do
      it 'cannot be updated if the extension of the image is svg.' do
        @user.cover = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/assets/images/vue.svg'))
        @user.valid?
        expect(@user.errors.full_messages).to include('カバー画像"svg"ファイルのアップロードは許可されていません。アップロードできるファイルタイプ: jpg, png')
      end
    end
  end
end
