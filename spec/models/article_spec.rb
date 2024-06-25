# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) {create(:user)}

  context 'タイトルと内容が入力されている場合' do
    let!(:article) {build(:article, user: user)}

    it '記事を保存できる' do
      expect(article).to be_valid
    end
  end
end
