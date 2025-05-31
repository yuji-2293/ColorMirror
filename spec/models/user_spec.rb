require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validationチェック" do
    it "設定したバリデーションが機能しているか" do
      user = build(:user)
      expect(user).to be_valid
      expect(user.errors).to be_empty
    end
  end
end


# require 'rails_helper'

# RSpec.describe Task, type: :model do
#   let(:user) { create(:user) } # ユーザー作成用のファクトリー
#   describe 'バリデーションチェック' do
#     it '設定したすべてのバリデーションが機能しているか' do
#       task = build(:task)
#       expect(task).to be_valid
#       expect(task.errors).to be_empty
#     end
#     it 'titleがない場合にバリデーションが機能してinvalidになるか' do
#       task_without_title = build(:task, title: "")
#       expect(task_without_title).to be_invalid
#       expect(task_without_title.errors[:title]).to_not be_empty
#     end

#     it 'statusがない場合にバリデーションが機能してinvalidになるか' do
#       task_without_status = build(:task, status: nil)
#       expect(task_without_status).to be_invalid
#       expect(task_without_status.errors[:status]).to_not be_empty
#     end

#     it 'titleが被った場合にuniqueのバリデーションが機能してinvalidになるか' do
#       task = create(:task)
#       duplicate_task = build(:task, title: task.title)
#       expect(duplicate_task).to be_invalid
#       expect(duplicate_task.errors[:title]).to_not be_empty
#     end

#     it 'titleが被らない場合にバリデーションエラーが起きないか' do
#       task = create(:task)
#       another_title = build(:task, title: 'another_title')
#       expect(another_title).to be_valid
#       expect(another_title.errors[:title]).to be_empty
#     end
#   end
# end
