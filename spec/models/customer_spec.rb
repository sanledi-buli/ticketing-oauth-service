require 'rails_helper'
RSpec.describe Customer, type: :model do
  def build_customer_with_options(options = {})
    build(:customer, options)
  end

  let(:customer) { FactoryGirl.create(:customer) }

  after(:each) do
    Customer.delete_all
  end

  describe 'validates' do

    context "#first_name" do

      it "should not valid if not present." do
        customer = build_customer_with_options(first_name: nil)
        expect(customer.valid?).to be_falsy
      end

      it "should not valid if contains special characters." do
        customer = build_customer_with_options(first_name: "foo'bar")
        expect(customer.valid?).to be_falsy
      end

      it "should valid if contains multiple words." do
        customer = build_customer_with_options(first_name: "foo")
        expect(customer.valid?).to eq true
      end

      it "should not valid if lenght more than 25 characters." do
        customer = build_customer_with_options(first_name: "foobar foobar foobar foobar")
        expect(customer.valid?).to be_falsy
      end

    end

    context "#last_name" do

      it "should valid if not present." do
        customer = build_customer_with_options(last_name: nil)
        expect(customer.valid?).to eq true
      end

      it "should not valid if contains special characters." do
        customer = build_customer_with_options(last_name: "foo'bar")
        expect(customer.valid?).to be_falsy
      end

      it "should not valid if lenght more than 25 characters." do
        customer = build_customer_with_options(last_name: "foobar foobar foobar foobar")
        expect(customer.valid?).to be_falsy
      end
    end

    context "#mobile_phone" do

      it "should not valid if not present." do
        customer = build_customer_with_options(mobile_phone: nil)
        expect(customer.valid?).to be_falsy
      end

      it "should not valid if wrong format." do
        customer = build_customer_with_options(mobile_phone: "+6298jsjsjs")
        expect(customer.valid?).to be_falsy
      end

      it "should valid if add country code." do
        customer = build_customer_with_options(mobile_phone: +6281000000)
        expect(customer.valid?).to eq true
      end

      it "should replace the Indonesian country code with zero" do
        phone = "81000000"
        code = "+62"
        customer = build_customer_with_options(mobile_phone: code+phone)
        customer.save!
        expect(customer.mobile_phone).to eq("0"+phone)
      end

      it "should not replace the Other country code with zero." do
        phone = "901111111"
        code = "+81"
        customer = build_customer_with_options(mobile_phone: code+phone)
        customer.save!
        expect(customer.mobile_phone).to eq(code+phone)
      end
    end

    context "#email" do

      it "should not valid if not present." do
        customer = build_customer_with_options(email: nil)
        expect(customer.valid?).to be_falsy
      end

      it "should not valid if missing domain." do
        customer = build_customer_with_options(email: "foo@.bar")
        expect(customer.valid?).to be_falsy
      end

      it "should not valid if missing top level domain." do
        customer = build_customer_with_options(email: "foo@bar.")
        expect(customer.valid?).to be_falsy
      end

      it "should not valid if duplicate email." do
        customer = build_customer_with_options(email: "foo@bar.baz")
        customer.save!
        duplicate_customer = build_customer_with_options(email: customer.email)
        expect(duplicate_customer.valid?).to be_falsy
      end

      it "should not error if format is valid." do
        customer = build_customer_with_options(email: "foo@bar.baz")
        expect(customer.valid?).to eq true
      end
    end

    context "#card_id" do

      it "should not valid if not present." do
        customer = build_customer_with_options(card_id: nil)
        expect(customer.valid?).to be_falsy
      end
    end

    context "#address" do

      it "should not valid if not present." do
        customer = build_customer_with_options(address: nil)
        expect(customer.valid?).to be_falsy
      end

      it "should not valid if lenght more than 50 characters." do
        customer = build_customer_with_options(address: "foobar foobar foobar foobar foobar foobar foobar foobar ")
        expect(customer.valid?).to be_falsy
      end
    end

    context "#city" do

      it "should not valid if not present." do
        customer = build_customer_with_options(city: nil)
        expect(customer.valid?).to be_falsy
      end
    end

    context "#country" do

      it "should not valid if not present." do
        customer = build_customer_with_options(country: nil)
        expect(customer.valid?).to be_falsy
      end
    end

    context "#nationality" do

      it "should not valid if not present." do
        customer = build_customer_with_options(nationality: nil)
        expect(customer.valid?).to be_falsy
      end
    end
  end
end
