module MoviesHelper
  def format_total_gross(movie)
    if movie.flop?
      content_tag(:p, "Flopped!")
    else
      number_to_currency(movie.total_gross)
    end
  end

  def image_for(movie)
    if movie.image_file_name.blank?
      image_tag("placeholder.jpg")
    else
      image_tag(movie.image_file_name)
    end
  end

  def format_average_stars(movie)
    # check if movie.average_star is nil if it is then you will
    if movie.average_stars.nil?
      content_tag(:strong, "NO REVIEWS")
    else
      # pluralize(number_with_precision(movie.average_stars, precision: 1), "star")
      num_asterisks = movie.average_stars.round
      "*" * num_asterisks
    end
  end
end
