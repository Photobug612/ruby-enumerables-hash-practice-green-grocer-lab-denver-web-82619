def consolidate_cart(cart)
  products_hash = {}
  cart.each do |product|
    product.each do |item, amount|
    products_hash[item] ||= amount
    products_hash[item][:count] ? products_hash[item][:count] += 1:
    products_hash[item][:count] =1 
    end
  end
products_hash
end

def apply_coupons(cart, coupons) 
  
  coupons.each do |coupon| 
    coupon.each do |a, value| 
      n = coupon[:item] 
    
      if cart[n] && cart[n][:count] >= coupon[:num] 
        if cart["#{n} W/COUPON"] 
          cart["#{n} W/COUPON"][:count] += coupon[:num]
        else 
          cart["#{n} W/COUPON"] = {:price => coupon[:cost]/coupon[:num], 
          :clearance => cart[n][:clearance], :count => coupon[:num] } 
        end 
  
      cart[n][:count] -= coupon[:num] 
    end 
  end 
end 
  cart 
end


def apply_clearance(cart) 
  cart.each do |item, a| 
    if a[:clearance] == true 
      a[:price] = (a[:price] * 0.8).round(2) 
    end 
  end 
cart 
end


def checkout(cart, coupons)
  total_due = 0 
final_cart = consolidate_cart(cart)
all_coupons = apply_coupons(cart, coupons) 
all_clearance = apply_clearance(cart)

all_clearance.each do |item, attribute_hash| 
  total += (attribute_hash[:price] * attribute_hash[:count]) 
 end
  total > 100 ? (total*0.9).round(2) : total
end

