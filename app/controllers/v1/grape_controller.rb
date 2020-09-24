# frozen_string_literal: true

module V1
  class GrapeController < ApplicationController

    def detail
      layout = request.xhr? ? 'raw' : 'grape_detail'
      render params[:template] || 'v1/callbacks/wallet_manager/transaction', layout: layout
    end
  end
end
