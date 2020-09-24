# frozen_string_literal: true

::V1::Exceptions.constants # 모든 예외 로딩


module V1
  class Mount < Grape::API

    PREFIX = '/api'

    version 'v1', using: :path

    cascade false

    format :json
    default_format :json
    default_error_formatter :json

    do_not_route_options!

    include ::V1::Exceptions::ExceptionHandlers

    before do
      header 'Access-Control-Allow-Origin', '*'
    end

    mount ::V1::Surveys

    scope :docs do
      before {}

      # /api/v1/docs
      base_path = PREFIX
      add_swagger_documentation(
        base_path:        base_path,
        array_use_braces: true,
        mount_path:       'docs',
        api_version:      'v1',
        doc_version:      'v1',
        info:             {title: 'API', description: ''},
        tags:             [
                            {name: 'surveys', description: '수요조사'},
                          ]
      )
    end
  end
end
