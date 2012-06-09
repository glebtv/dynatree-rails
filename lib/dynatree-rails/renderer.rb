# Configure for Rails 3.1
module Dynatree
  class Renderer
    def initialize(tree, association)
      @tree = tree
      @association = association
    end

    def render()
      self.recurse(nil).to_json
    end

    def has_selected_children(id)
      items = @tree.select{ |elem| elem.parent_id == id }
      if items.empty?
        false
      else
        items.each do |item|
          if @association.include? item
            return true
          end
          if has_selected_children(item.id)
            return true
          end
        end
        false
      end
    end

    def recurse(parent_id)
      ret = []
      items = @tree.select{ |elem| elem.parent_id == parent_id }
      unless items.empty?
        items.each do |item|
          ch = {}
          if @association.include? item
            ch['select'] = true
            ch['expand'] = true
          else
            if has_selected_children(item.id)
              ch['expand'] = true
            end
          end
          ch['title'] = item.name
          ch['key']   = item.id.to_s
          ch['children'] = self.recurse(item.id)
          ret << ch
        end
      end
      ret
    end
  end
end