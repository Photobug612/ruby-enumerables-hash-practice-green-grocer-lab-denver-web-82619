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
  running_total = 0 
  new_cart = consolidate_cart(cart) 
  coupons = c(new_cart, coupons) 
  clearance = discount(coupon_cart) 
  clearance.each do |item, a| 
    running_total += (a[:price] * a[:count])
  end 
running_total = (running_total * 0.9) if running_total > 100 running_total 
end