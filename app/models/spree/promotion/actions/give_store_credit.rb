module Spree
  class Promotion::Actions::GiveStoreCredit < PromotionAction
    include Spree::Core::CalculatedAdjustments
    include Spree::Core::AdjustmentSource

    has_many :adjustments, as: :source

    before_validation :ensure_action_has_calculator

    def perform(options = {})
      user = lookup_user(options)
      give_store_credit(user) if user.present?
    end

    def lookup_user(options)
      options[:user]
    end

    def give_store_credit(user)
      user.store_credits.create(:amount => calculator.preferred_amount, :remaining_amount => calculator.preferred_amount, :reason => credit_reason)
    end

    def credit_reason
      "#{Spree.t(:promotion)} #{promotion.name}"
    end


    private

    def ensure_action_has_calculator
      return if self.calculator
      self.calculator = Calculator::FlatRate.new
    end

  end
end
