get '/api/v1/grape/detail' => 'v1/grape#detail'

mount GrapeSwaggerRails::Engine => '/swagger'
