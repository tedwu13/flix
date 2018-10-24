# using delegate in rails

class QueueItem < ActiveRecord::Base
  belongs_to :video

end

class Video < ActiveRecord::Base
  has_many :queue_items
  belongs_to :category
end

class Category < ActiveRecord::Base
  has_many :video
end

# cumbersome wirthout delegate
# if we want to get category from one queue item
queue_item = QueueItem.first
queue_item.video.category


class QueueItem < ActiveRecord::Base
  belongs_to :video

  delegate :category, to: :video
end
# this exposes video category so instead we can just delegate category to the video

queue_item = QueueItem.first
queue_item.video.category
