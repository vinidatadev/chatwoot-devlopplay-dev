class SetEnterprisePricingPlan < ActiveRecord::Migration[7.0]
  def up
    config = InstallationConfig.find_or_initialize_by(name: 'INSTALLATION_PRICING_PLAN')
    config.value = 'enterprise'
    config.locked = false
    config.save!

    config2 = InstallationConfig.find_or_initialize_by(name: 'INSTALLATION_PRICING_PLAN_QUANTITY')
    config2.value = 999
    config2.locked = false
    config2.save!
  end

  def down
    InstallationConfig.where(name: ['INSTALLATION_PRICING_PLAN', 'INSTALLATION_PRICING_PLAN_QUANTITY']).destroy_all
  end
end
