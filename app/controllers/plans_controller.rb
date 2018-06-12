# frozen_string_literal: true

class PlansController < ApplicationController
  def index
    @plans = Plan.active

    render json: @plans
  end
end
