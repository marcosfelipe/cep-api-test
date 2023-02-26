# Calls the Addresses service to create a new Address cache
class AddressCreatorJob < ApplicationJob
  class UserNotFoundError < StandardError; end

  def perform(args)
    @args = args
    AddressesService.new(address_attributes, user).save
  end

  private

  attr_reader :args

  def address_attributes
    args[:address_attributes] || {}
  end

  def user
    @user ||= User.find(args[:user_id])
  rescue ActiveRecord::RecordNotFound
    raise UserNotFoundError
  end
end
