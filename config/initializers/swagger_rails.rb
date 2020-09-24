
GrapeSwaggerRails.options.url = '/api/v1/docs'
# GrapeSwaggerRails.options.api_key_name = 'api_key'
# GrapeSwaggerRails.options.api_key_type = 'header'
GrapeSwaggerRails.options.hide_url_input = true

GrapeSwaggerRails.options.before_action do
  GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
end
