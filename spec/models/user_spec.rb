require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'DB table' do
        it { is_expected.to have_db_column :id }
        it { is_expected.to have_db_column :email }
        it { is_expected.to have_db_column :encrypted_password }
        it { is_expected.to have_db_column :role }
        it { is_expected.to have_db_column :provider }
        it { is_expected.to have_db_column :uid }
        it { is_expected.to have_db_column :reset_password_token }
        it { is_expected.to have_db_column :reset_password_sent_at }
        it { is_expected.to have_db_column :remember_created_at }
        it { is_expected.to have_db_column :confirmation_token }
        it { is_expected.to have_db_column :confirmed_at }
        it { is_expected.to have_db_column :confirmation_sent_at }
        it { is_expected.to have_db_column :unconfirmed_email }
        it { is_expected.to have_db_column :nickname }
        it { is_expected.to have_db_column :image }
        it { is_expected.to have_db_column :tokens }
        it { is_expected.to have_db_column :created_at }
        it { is_expected.to have_db_column :updated_at }

    end

    describe 'Associations' do
        it { should have_many(:articles) }
      end

    describe 'Factory' do
        it 'should have valid Factory' do
            expect(FactoryBot.create(:user)).to be_valid 
        end
    end

    describe 'Validations' do
        it { is_expected.to validate_presence_of(:email) }
        it { is_expected.to validate_confirmation_of(:password) }
    
        context 'should not have an invalid email address' do
          emails = ['asdf@ ds.com', '@example.com', 'test me @yahoo.com',
                    'asdf@example', 'ddd@.d. .d', 'ddd@.d']
    
          emails.each do |email|
            it { is_expected.not_to allow_value(email).for(:email) }
          end
        end
    
        context 'should have a valid email address' do
          emails = ['asdf@ds.com', 'hello@example.uk', 'test1234@yahoo.si',
                    'asdf@example.eu']
    
          emails.each do |email|
            it { is_expected.to allow_value(email).for(:email) }
          end
        end
    end
end