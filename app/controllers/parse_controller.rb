class ParseController < ApplicationController
  def index
    @import = Import.all
  end

  def new; end

  def create
    parse_csv = Import.create(file: params[:file].path)
    redirect_to controller: 'parse', action: 'index' if parse_csv
  end
end
