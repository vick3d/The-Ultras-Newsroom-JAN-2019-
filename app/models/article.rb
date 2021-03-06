class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    validates :lead, presence: true
    has_and_belongs_to_many :categories
end