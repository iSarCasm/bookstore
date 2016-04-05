class GenerateSlug < ActiveRecord::Migration
  def change
    Book.where(slug: nil).each { |x| x.save}
  end
end
