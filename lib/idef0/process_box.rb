require_relative 'box'
require_relative 'labels'

# TODO: Probably could just call this a ChildBox?
module IDEF0
  class ProcessBox < Box
    attr_accessor :sequence

    def precedence
      [-right_side.anchor_count, [left_side, top_side, bottom_side].map(&:anchor_count).reduce(&:+)]
    end

    def width
      name_multi = @name.split("\n")
      maxlength=0
      for i in name_multi
        maxlength=[Label.length(i), maxlength].max
      end
      [maxlength+40, [top_side.anchor_count, bottom_side.anchor_count].max*20+20].max
    end

    def height
      [60, [left_side.anchor_count, right_side.anchor_count].max*20+20].max
    end

    def lineheight
      15
    end

    def after?(other)
      sequence > other.sequence
    end

    def before?(other)
      sequence < other.sequence
    end

    def to_svg
      output=""+
"<rect x='#{x1}' y='#{y1}' width='#{width}' height='#{height}' fill='none' stroke='black' />\n"
      name_multi = name.split("\n")
      for i in 1..name_multi.length
        output+="<text text-anchor='middle' x='#{x1 + (width / 2)}' y='#{y1 + (height / 2) -(name_multi.length-1)/2.0*lineheight+(i-1)*lineheight }'>#{name_multi[i-1]}</text>"
      end
        <<-XML
      #{output}
      XML
    end
  end
end
