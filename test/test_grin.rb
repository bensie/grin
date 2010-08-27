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

    context "creating and deleting albums and categories" do
      setup do
        @category = @fotogger.find_or_create_category("My Category")
        @album = @fotogger.find_or_create_album("My Album", @category.id)
      end

      should "return the category name" do
        assert_kind_of Grin::Category, @category
        assert_equal @category.name, "My Category"
      end

      should "return the album title and category name" do
        assert_kind_of Grin::Album, @album
        assert_equal @album.title, "My Album"
        assert_equal @album.category['name'], @category.name
      end

      should "not allow you to delete the category when the album exists" do
        response = @category.destroy
        assert_equal "Cannot delete category that contains albums", response['error']
      end

      should "delete the album followed by the category" do
        album_response = @album.destroy
        category_response = @category.destroy
        assert_equal "ok", album_response['status']
        assert_equal "ok", category_response['status']
      end

    end

  end

end
