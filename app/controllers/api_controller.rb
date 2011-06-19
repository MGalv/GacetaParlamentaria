class ApiController < ApplicationController
  respond_to :json

  def gazettes
    gazettes = Gazette.all
    respond_with(gazettes) do |format|
      format.json { render_for_api :gazette, :json => gazettes }
    end
  end
end
