require 'spec_helper'

describe Forum do
  before { @forum = Forum.new(name: "Main", subname: "The main forum", creator: "Me") }

  subject { @forum }

  it { should respond_to(:name) }
  it { should respond_to(:subname) }
  it { should respond_to(:creator) }
  it { should respond_to(:posts) }

  it { should be_valid }

  describe "thread association" do
    before { @forum.save }

    let!(:older_post) do
      FactoryGirl.create(:post, forum: @forum, updated_at: 1.day.ago)
    end

    let!(:newer_post) do
      FactoryGirl.create(:post, forum: @forum, updated_at: 1.hour.ago)
    end

    it "should have the posts in the right order" do
      expect(@forum.posts.to_a).to eq [newer_post, older_post]
    end

    it "should destroy associated posts" do
      posts = @forum.posts.to_a
      @forum.destroy
      expect(posts).not_to be_empty
      posts.each do |post|
        expect(Post.where(id: post.id)).to be_empty
      end
    end
  end
end
