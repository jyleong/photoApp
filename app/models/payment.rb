class Payment < ActiveRecord::Base

  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year
  belongs_to :user
  ##needs to work with the attributes of credit cards
  
  def self.month_options
    
    Date::MONTHNAMES.compact.each_with_index.map {|name, i| ["#{i+1} - #{name}", i +1]}
  end
  
  def self.year_options
    (Date.today.year..(Date.today.year+10)).to_a
  end
  
  def process_payment
    customer = Stripe::Customer.create email: email, card: token
    Stripe::Charge.create customer: customer.id, amount: 1000,
                                  description: 'Premium', currency: 'usd'
  end
  
  def create
    @registration = Registration.new registration_params.merge(email: stripe_params["stripeEmail"],
                                                               card_token: stripe_params["stripeToken"])
    raise "Please, check registration errors" unless @registration.valid?
    @registration.process_payment
    @registration.save
    redirect_to @registration, notice: 'Registration was successfully created.'
  end
end
