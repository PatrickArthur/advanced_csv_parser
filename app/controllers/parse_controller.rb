class ParseController < ApplicationController

  def index
    @records = Record.all
  end

  def new
  end

  def create
    parse_csv = ParseCsv.new(params[:file].path)
    parse_csv.read_find_dups
    redirect_to controller: 'parse', action: 'index'
  end
end
