class HomeController < ApplicationController
  def index
    @rtables = RTable.all
    @floor = Floor.first
  end

end
