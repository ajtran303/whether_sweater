class Error
  attr_reader :status, :source, :title, :detail
  def initialize(params)
    @status = params[:status]
    @source = {pointer: params[:source]}
    @title = params[:title]
    @detail = params[:detail]
  end
end
