class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).group("captains.id").where({"classifications.name":"Catamaran"})
  end

  def self.sailors
    self.joins(boats: :classifications).group("captains.id").where({"classifications.name":"Sailboat"})
  end

  def self.motorboaters
    self.joins(boats: :classifications).group("captains.id").where({"classifications.name":"Motorboat"})
  end

  def self.talented_seamen
    self.where("id IN (?)", self.sailors.pluck(:id) & self.motorboaters.pluck(:id))
  end

  def self.non_sailors
    self.where("id NOT IN (?)", self.sailors.pluck(:id))
  end
end
