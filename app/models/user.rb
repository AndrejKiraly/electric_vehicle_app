# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :chargings, dependent: :destroy, 
  has_many :ev_stations, dependent: :destroy, foreign_key: :created_by_id
  has_many :connections, dependent: :destroy, foreign_key: :created_by_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

end
