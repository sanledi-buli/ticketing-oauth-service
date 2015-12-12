require 'rails_helper'
RSpec.describe Customer, type: :model do
  def build_customer_with_options(options = {})
    build(:customer, options)
  end

  before(:each) do
    @customer = FactoryGirl.create(:customer)
  end

  after(:each) do
    Customer.delete_all
  end

  describe "ActiveModel validations" do
    it { should validate_presence_of(:first_name) }
    it { should_not allow_value(" ").for(:first_name) }
    it { should_not allow_value("foo'bar").for(:first_name) }
    it { should allow_value("foo bar").for(:first_name) }
    it { should validate_length_of(:first_name).is_at_most(25) }
    
    it { should_not validate_presence_of(:last_name) }
    it { should_not allow_value("foo'bar").for(:last_name) }
    it { should allow_value("foo bar").for("last_name") }
    it { should validate_length_of(:last_name).is_at_most(25) }

    it { should validate_presence_of(:mobile_phone) }
    it { should_not allow_value("+629990jskaka").for(:mobile_phone) }
    it { should allow_value("+620000000").for(:mobile_phone) }

    it { should_not validate_presence_of(:phone) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should_not allow_value("@foo.baz").for(:email) }
    it { should_not allow_value("bar@.baz").for(:email) }
    it { should_not allow_value("bar@foo").for(:email) }
    it { should allow_value("bar123@foo.baz").for(:email) }

    it { should validate_presence_of(:card_id) }

    it { should validate_presence_of(:address) }
    it { should validate_length_of(:address).is_at_most(50) }

    it { should validate_presence_of(:city) }

    it { should validate_presence_of(:nationality) }

    it { should validate_presence_of(:country) }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should_not allow_value("foo*&^(bar123").for(:password) }
    it { should allow_value("QweRty1234").for(:password) }

    it { should define_enum_for(:status).with([:non_active, :active, :blacklist]) }

  end

  context "callbacks" do
    it { is_expected.to callback(:replace_country_code_indonesia).before(:validation) }
    it { is_expected.to callback(:downcase_email).before(:validation) }
    it "should replace Indonesian country code with zero." do
      phone = "810000000"
      country_code = "+62"
      customer = build_customer_with_options(mobile_phone: country_code+phone)
      customer.save!
      expect(customer.mobile_phone).to eq("0"+phone)
    end

    it "should not replace the Other country code with zero." do
      phone = "810000000"
      country_code = "+81"
      customer = build_customer_with_options(mobile_phone: country_code+phone)
      customer.save!
      expect(customer.mobile_phone).to eq(country_code+phone)
    end
  end

end
