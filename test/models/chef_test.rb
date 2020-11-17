require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    def setup
        @chef = Chef.new(chefname: 'nano', email: "nano@example.com")
    end

    test "chef should be valid" do 
        assert @chef.valid?
    end

    test "name should be present" do 
        @chef.chefname = " "
        assert_not @chef.valid?
    end

    test "name should be maximum 30 characters" do 
        @chef.chefname = "a" * 31
        assert_not @chef.valid?
    end

    test "email should be present" do 
        @chef.email = " "
        assert_not @chef.valid?
    end

    test "email should be maximum 255 characters" do 
        @chef.email = "a" * 256
        assert_not @chef.valid?
    end

    test "email should accept correct format" do 
        valid_emails = %w[user@example.com nano@gmail.com M.first@yahoo.ca john+smith@co.uk.org]
        valid_emails.each do |valids| 
            @chef.email = valids
            assert @chef.valid?, "#{valids.inspect} should be valid"
        end
    end

    test "should reject invalid addresses" do 
        invalid_emails = %w[nano@example nano@example,com nano.name@gmail. joe@bar+foo.com]
        invalid_emails.each do |invalids|
            @chef.email = invalids
            assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
        end
    end

    test "email should be unique and case insensitive" do 
        duplicate_chef = @chef.dup 
        duplicate_chef.email = @chef.email.upcase 
        @chef.save
        assert_not duplicate_chef.valid?
    end

    test "email should be lowercase before hitting db" do 
        mixed_email = "JohN@Example.com"
        @chef.email = mixed_email
        @chef.save
        assert_equal mixed_email.downcase, @chef.reload.email 
    end
end