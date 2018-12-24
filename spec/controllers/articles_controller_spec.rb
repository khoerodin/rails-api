require 'rails_helper'

describe ArticlesController do
  subject { get :index }

  describe '#index' do
    it 'should return success response' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      subject
      Article.recent.each_with_index do |article, index|
        expect(json_data[index]['attributes']).to eq({
          "title" => article.title,
          "content" => article.content,
          "slug" => article.slug
        })
      end
    end

    it 'should return articles in the propper order' do
      old_article = create :article
      newer_article = create :article
      subject
      expect(json_data.first['id']).to eq(newer_article.id.to_s)
      expect(json_data.last['id']).to eq(old_article.id.to_s)
    end

    it 'should paginate result' do
      create_list :article, 3
      get :index, params: { page: 2, per_page: 1}
      expect(json_data.length).to eq(1)
      expect(json_data.first['id']).to eq(Article.recent.second.id.to_s)
    end
  end
end
