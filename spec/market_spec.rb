require 'spec_helper'
RSpec.describe Vendor do 
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
  end
  it 'exists' do
    expect(@market).to be_a Market
  end

  it 'has a name' do
    expect(@market.name).to eq("South Pearl Street Farmers Market")
  end

  it 'has vendors array' do
    expect(@market.vendors).to eq([])
  end

  it 'can add vendors' do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
  end

  it 'can access vendor names' do
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendor_names).to eq([@vendor1.name, @vendor2.name, @vendor3.name])
  end

  it 'can see if vendor sells an item' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
    expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
  end

  it 'can return potential revenue for each vendor' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@vendor1.potential_revenue).to eq(29.75)
    expect(@vendor2.potential_revenue).to eq(345.00)
    expect(@vendor3.potential_revenue).to eq(48.75)
  end

  it 'can return a list of names of all of the items' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.sorted_item_list).to eq([@item4, @item1, @item3, @item2])
  end

  it 'can return total inventory' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.total_inventory).to eq(@market.total_inventory)
  end

  it 'can return overstocked items' do
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7) 
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    @market.add_vendor(@vendor1)
    @market.add_vendor(@vendor2)
    @market.add_vendor(@vendor3)
    expect(@market.overstocked_items).to eq([@item1])
  end

  # it 'can sell items' do
  #   @vendor1.stock(@item1, 35)
  #   @vendor1.stock(@item2, 7) 
  #   @vendor2.stock(@item4, 50)
  #   @vendor2.stock(@item3, 25)
  #   @vendor3.stock(@item1, 65)
  #   @market.add_vendor(@vendor1)
  #   @market.add_vendor(@vendor2)
  #   @market.add_vendor(@vendor3)
  #   expect(@market.sell(@item1, 50)).to eq(true)
  #   expect(@market.total_inventory[:item1][:quantity]).to eq(50)
  # end
end