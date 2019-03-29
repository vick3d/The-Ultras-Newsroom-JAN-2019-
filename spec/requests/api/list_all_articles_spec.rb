require 'rails_helper'

describe "Get /api/articles" do
    let(:category){create(:category)}
    let!(:articles){ 5.times {FactoryBot.create(:article)}}
    let(:headers){ {HTTP_ACCEPT: "application/json"} }
    
    it "returns a collection of 5 articles" do
        get '/api/articles', headers: headers
        expect(JSON.parse(response.body)['articles'].count).to eq 5
    end
end