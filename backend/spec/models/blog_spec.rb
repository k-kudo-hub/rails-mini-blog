require 'rails_helper'

RSpec.describe Blog, type: :model do
  before do
    @blog = FactoryBot.build(:blog)
  end

  # bundle exec rspec spec/models/blog_spec.rb

  describe 'Create blog' do
    context 'Create blog is successful' do
      it 'If subject, state_number, url exist, you can create.' do
        expect(@blog).to be_valid
      end

      it 'If body is empty, it can be create' do
        @blog.body = ''
        expect(@blog).to be_valid
      end

      it 'If the cover image is empty, you can save it.' do
        @blog.cover_image = nil
        expect(@blog).to be_valid
      end
    end

    context 'Create blog is not working' do
      it 'If Subject is empty, it cannot be created.' do
        @blog.subject = ''
        @blog.valid?
        expect(@blog.errors.full_messages).to include('タイトルを入力してください')
      end

      it 'If the URL is empty, it cannot be created.' do
        @blog.url = ''
        @blog.valid?
        expect(@blog.errors.full_messages).to include('URLを入力してください')
      end

      it 'If the subject is 50 characters or more, it cannot be created.' do
        @blog.subject = 'a' * 51 
        @blog.valid?
        expect(@blog.errors.full_messages).to include('タイトルは50文字以内で入力してください')
      end

      it 'If the state number is empty, it cannot be created.' do
        @blog.state_number = nil
        @blog.valid?
        expect(@blog.errors.full_messages).to include('公開状態を入力してください')
      end

      it 'If the state number is not number, it cannot be created.' do
        @blog.state_number = 'hello, world'
        @blog.valid?
        expect(@blog.errors.full_messages).to include('公開状態は数値で入力してください')
      end

      it 'If the state number is not between 0 and 3., it cannot be created.' do
        @blog.state_number = 4
        @blog.valid?
        expect(@blog.errors.full_messages).to include('公開状態は一覧にありません')
      end

      it 'If the extension of cover image is .svg, it cannot be created.' do
        @blog.cover_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/assets/images/vue.svg'))
        @blog.valid?
        expect(@blog.errors.full_messages).to include('カバー画像"svg"ファイルのアップロードは許可されていません。アップロードできるファイルタイプ: jpg, png')
      end

      it 'If the URL was already in use, it cannot be created.' do
        @blog.save
        @blog2 = FactoryBot.build(:blog)
        @blog2.url = @blog.url
        @blog2.valid?
        expect(@blog2.errors.full_messages).to include('URLの生成で問題が発生しました。お手数ですが再度「保存する」を押してください。')
      end
    end
  end
end
