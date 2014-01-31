# Dynatree-Rails

A Dynatree integration for rails 3.1+ asset pipeline

http://code.google.com/p/dynatree/

## Installation

Add this line to your application's Gemfile:

    gem 'dynatree-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dynatree-rails

## Usage

css:

    //= require dynatree/skin

or

    //= require dynatree/skin-vista

js:

    //= require dynatree/jquery.dynatree

For dynatree usage and examples see: http://code.google.com/p/dynatree/

## An optional model-to-javascript tree renderer for mongoid_nested_set

Can be used to turn association select to a tree select, like this:



    #checkboxes
        -# with simple_form
        = f.association :categories, as: :check_boxes, collection: Category.all

        -# with formtastic
        = f.input :categories, as: :check_boxes, collection: Category.all

        -# without any
        - Category.each do |c|
          = check_box_tag "item[category_ids][]", c.id, @item.category_ids.include?(c.id)

    #tree.controls.input{style: 'width: 220px;'}

    :javascript
        var categories = #{Dynatree::Renderer.new(Category.nested_set.all, f.object.categories).render()};
        $(function(){
            $('#checkboxes').hide();

            $("#tree").dynatree({
                checkbox: true,
                selectMode: 3,
                classNames: {
                    active: "dynatree-active-no"
                },
                children: categories
            });

            $("form").submit(function() {
                var tree = $("#tree").dynatree("getTree"),
                    arr = tree.serializeArray(),
                    sel = $('#checkboxes');
                sel.find(':checked').prop('checked', false);
                $.each(arr, function(k, v) {
                    sel.find('[value=' + v.value + ']').prop('checked', true);
                });
            });
        });

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Dynatree is

	Copyright (c) 2008-2011, Martin Wendt (http://wwWendt.de)
	Dual licensed under the MIT or GPL Version 2 licenses.
	http://code.google.com/p/dynatree/wiki/LicenseInfo

This code is:

	Copyright (c) 2012-2014, Gleb Tv
	Dual licensed under the MIT or GPL Version 2 licenses.
