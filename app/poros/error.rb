class Error
  def self.unsupported(request_path)
    params = {
      status:'415',
      source: request_path,
      title: 'Unsupported Media Type',
      detail: 'This API conforms to the JSON API Spec. ' +
               'Requests must have the header ' +
               '`Content-Type: application/vnd.api+json`.'
    }
    new(params)
  end

  attr_reader :status, :source, :title, :detail

  def initialize(params)
    @status = params[:status]
    @source = {pointer: params[:source]}
    @title = params[:title]
    @detail = params[:detail]
  end
end
