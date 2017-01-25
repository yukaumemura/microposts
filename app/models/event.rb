class Event < ActiveRecord::Base
    has_many :clips
    has_many :users, through: :clips
end