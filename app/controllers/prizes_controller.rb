# frozen_string_literal: true

class PrizesController < ApplicationController
    before_action :authenticate_user!

    def index
      @prizes = Prize.all
    end
end
  