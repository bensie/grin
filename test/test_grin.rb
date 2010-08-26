require 'helper'

class TestGrin < Test::Unit::TestCase
  SUBDOMAIN = ""
  EMAIL     = ""
  PASSWORD  = ""

  context "New connection" do

    setup do
      @fotogger = Grin::Client.new(SUBDOMAIN, EMAIL, PASSWORD)
    end

    should "return albums and categories without errors" do
      assert_nothing_raised do
        @fotogger.albums
        @fotogger.categories
      end
    end

    context "creating albums and categories" do
      setup do
        @category = @fotogger.find_or_create_category("My Category")
        @album = @fotogger.find_or_create_album("My Album", @category.id)
      end

      should "return the category name" do
        assert_equal @category.name, "My Category"
      end

      should "return the album title and category name" do
        @category = @fotogger.find_or_create_category("My Category")

        assert_equal @album.title, "My Album"
        assert_equal @album.category['name'], @category.name
      end
    end

  end

end
