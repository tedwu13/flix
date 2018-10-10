class EventsController < ApplicationController
  def index
    @events = ["BugSmash", "Hackathon", "Kata Kamp"]
    @time = Time.now
  end
end
