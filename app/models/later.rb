class Later < ActiveRecord::Base
  belongs_to :account
  validates :user_id, presence: true

  def self.get_ograph_content(later_id)
    later = Later.find(later_id)
    
    open_graph = MetaInspector.new(later.url)
    later.image_url = open_graph.meta_tags["property"]['og:image'].first
    later.title = open_graph.meta_tags["property"]['og:title'].first
    later.content_updated = Time.now
    later.description = open_graph.meta_tags["property"]['og:description'].first
    later.save
  end

  def self.check_for_ready_laters
    ready_laters = Later.where( has_sent: false).where('destined_at < ?', Time.now ).order(destined_at: :asc)
    ready_laters.each do |later|
      ContentMailer.delay.content_email(later.id)
    end
  end
end
