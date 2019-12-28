class EmailTemplate < ApplicationRecord
  has_rich_text :body

  validates :title
end
