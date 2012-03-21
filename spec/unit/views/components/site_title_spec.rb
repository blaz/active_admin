require 'spec_helper'

describe ActiveAdmin::Views::SiteTitle do

  setup_arbre_context!

  def build_title(namespace)
    insert_tag ActiveAdmin::Views::SiteTitle, namespace
  end

  context "when a value" do

    it "renders the string when a string is passed in" do
      namespace = mock :site_title => "Hello World", 
                       :site_title_image => nil,
                       :site_title_link => nil

      site_title = build_title(namespace)
      site_title.content.should == "Hello World"
    end

    it "renders the return value of a method when a symbol" do
      helpers.should_receive(:hello_world).and_return("Hello World")

      namespace = mock :site_title => :hello_world,
                       :site_title_image => nil,
                       :site_title_link => nil

      site_title = build_title(namespace)
      site_title.content.should == "Hello World"
    end

    it "renders the return value of a proc" do
      namespace = mock :site_title => proc{ "Hello World" },
                       :site_title_image => nil,
                       :site_title_link => nil

      site_title = build_title(namespace)
      site_title.content.should == "Hello World"
    end

  end

  context "when an image" do

    it "renders the string when a string is passed in" do
      helpers.should_receive(:image_tag).
        with("an/image.png", {:alt => nil, :id => "site_title_image"}).
        and_return("<img src=\"/assets/an/image.png\" />".html_safe)

      namespace = mock :site_title => nil,
                       :site_title_image => "an/image.png",
                       :site_title_link => nil

      site_title = build_title(namespace)
      site_title.content.strip.should == "<img src=\"/assets/an/image.png\" />"
    end

  end

  context "when a link is present" do

    it "renders the string when a string is passed in" do
      namespace = mock :site_title => "Hello World", 
                       :site_title_image => nil,
                       :site_title_link => "/"

      site_title = build_title(namespace)
      site_title.content.should == "<a href=\"/\">Hello World</a>"
    end

  end



end
