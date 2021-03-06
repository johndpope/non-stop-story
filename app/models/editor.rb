# frozen_string_literal: true

class Editor < ApplicationRecord
  has_many :channels
  has_and_belongs_to_many :arranges
  validates :name, presence: true
end
