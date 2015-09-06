class Bottom < ActiveRecord::Base
  serialize :properties
  serialize :batch_information
  
  has_many :user_bottoms
  has_many :users, :through => :user_bottoms
  
  belongs_to :outfit
  
  attr_accessible :batch_information, :number, :file_name, :url, :properties
end