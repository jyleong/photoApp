class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :payment ##only required once to make payment to signup for site
  accepts_nested_attributes_for :payment ##handle signup user through registrations form
  has_many :images
end
