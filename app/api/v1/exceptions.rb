# frozen_string_literal: true

module V1
  module Exceptions
    extend ActiveSupport::Autoload
  end
end

Dir[Pathname(__FILE__).dirname / "exceptions/**/*rb"].each(&method(:require))
