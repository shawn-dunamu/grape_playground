# frozen_string_literal: true

module V1
  module Exceptions
    module ExceptionHandlers

      # @see Raven::Rack
      # @see Airbrake::Rack::Middleware
      # @see RorVsWildExt::Rack::Middleware
      def self.included(base)
        base.instance_eval do
          # rescue_from(:all, backtrace: !Rails.env.production?) do |e|
          rescue_from(:all) do |e|

            response_headers = -> { @response_headers = {'Content-Language'.freeze => I18n.locale.to_s,
                                                         Grape::Http::Headers::CONTENT_TYPE => content_type} }

            # env['rack.exception'] = e if e.class.try(:error_class) or e.class.try(:log_class) # Airbrake, RorVsWildExt
            env['rack.exception'] = e if e.class.try(:log_class) # Airbrake, RorVsWildExt
            if e.is_a?(::V1::Exceptions::Base)
              e.try(:log_attributes)
              rack_response(format_message(e.response, e.backtrace), e.status || 500, response_headers.call)
            elsif e.instance_of?(Grape::Exceptions::ValidationErrors)
              env['rack.exception'] = e
              Rack::Response.new(
                  {
                      error: {
                          name: 'validation_error',
                          message: e.message
                      }
                  }.to_json, e.status, response_headers.call)
            elsif e.is_a?(Grape::Exceptions::Base)
              rack_response(format_message(e.message, e.backtrace), e.try(:status) || 500, response_headers.call)
            elsif e.is_a?(ActiveRecord::RecordNotFound)
              ex = ::V1::Exceptions::NotFound.new(e)
              rack_response(format_message(ex.response, e.backtrace), ex.status)
            else
              raise e if Rails.env.test?
              ex = ::V1::Exceptions::ServerError.new(e)
              rack_response(format_message(ex.response, e.backtrace), ex.try(:status) || 500, response_headers.call)
            end
          end
        end


      end

    end
  end
end
