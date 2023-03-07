class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map(&:name)
  end

  def vendors_that_sell(item)
    @vendors.select { |vendor| vendor.inventory.include?(item) }
  end

  def sorted_item_list
    items = @vendors.flat_map { |vendor| vendor.inventory.keys }
    items.uniq.sort_by(&:name)
  end

  def total_inventory
    inventory = Hash.new { |hash, key| hash[key] = { quantity: 0, vendors: [] } }
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        inventory[item][:quantity] += quantity
        inventory[item][:vendors] << vendor
      end
    end
    inventory
  end

  def overstocked_items
    items_over_50 = total_inventory.select { |item, data| data[:quantity] > 50 }
    items = items_over_50.keys
    items.select { |item| vendors_that_sell(item).size > 1 }
  end

  # def sell(item, quantity)
  #   available_quantity = total_inventory[item][:quantity]
  #   return false if available_quantity < quantity
  
  #   vendors_that_sell(item).each do |vendor|
  #     vendor_quantity = vendor.inventory[item]
  #     next unless vendor_quantity.positive?
  
  #     sold_quantity = [quantity, vendor_quantity].min
  #     vendor.inventory[item] -= sold_quantity
  #     total_inventory[item][:quantity] -= sold_quantity
  #     quantity -= sold_quantity
  
  #     return true if quantity.zero?
  #   end
  
  #   false
  # end
  
end

