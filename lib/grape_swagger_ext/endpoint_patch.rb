# frozen_string_literal: true

module GrapeSwaggerExt
  module EndpointPatch
    def summary_object(route)
      summary = route.options[:desc] if route.options.key?(:desc)
      summary = route.description if route.description.present?
      summary = route.options[:summary] if route.options.key?(:summary)

      summary
    end
  end

  ::Grape::Endpoint.prepend EndpointPatch
end
