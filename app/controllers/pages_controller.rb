class PagesController < ApplicationController
  def home
    @recent_causes = Cause.order(created_at: :desc).limit(3)
    @our_volunteers = Volunteer.limit(10)
  end 

  def contact
  end 
end
