module ReviewsHelper

  def format_review(review)
    text = "#{review.stars} stars by #{review.name}: #{review.comment}"
    content_tag(:p, text)
  end
end
