class Product < ActiveRecord::Base
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	private
		# ensure that there are not line item referenceing this product
		def ensure_not_referenced_by_any_line_item
			if line_items.empty?
				return true
			else
				errors.add(:base, 'Line Items present')
				return false
			end
		end

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, :image_url, uniqueness: true
	validates :image_url, allow_blank: true, format: {
		with:	%r{\.(gif|jpg|png)$}i,
		message: 'must be a URL for GIF, JPG or PNG image.',
		multiline: true
	}
end
