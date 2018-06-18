class ParseController < ApplicationController

  def index
    @import = Import.all
  end

  def new
  end

  def create
    parse_csv = Import.create(file: params[:file].path)
    if parse_csv
      redirect_to controller: 'parse', action: 'index'
    end
  end
end
