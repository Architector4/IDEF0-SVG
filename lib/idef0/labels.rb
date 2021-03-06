module IDEF0
  class Label
    def self.length(text)
      #text.length * 6
      max = 0
      text.split("\n").each{
        |t| max=[max,t.length].max
      }
      max * 6
    end

    def initialize(text, point)
      @text = text
      @point = point
    end

    def length
      self.class.length(@text)
    end

    def top_edge
      @point.y - 20
      #@point.y - 5 - @text.split("\n").length*lineheight
    end

    def bottom_edge
      @point.y
    end

    def right_edge
      left_edge + length
    end

    def lineheight
      15
    end

    def overlapping?(other)
      left_edge < other.right_edge &&
        right_edge > other.left_edge &&
        top_edge < other.bottom_edge &&
        bottom_edge > other.top_edge
    end

    def to_svg
      #output="<text text-anchor='#{text_anchor}' x='#{@point.x}' y='#{@point.y}'>#{@text}</text>"
      output=""
      text_multi = @text.split("\n")
      for i in 1..text_multi.length
        output+="<text text-anchor='#{text_anchor}'
        x='#{@point.x}'
        y='#{@point.y - (text_multi.length - i ) * lineheight}'>
        #{text_multi[i-1]}</text>"
      end
      output
    end
  end

  class LeftAlignedLabel < Label
    def left_edge
      @point.x
    end

    def text_anchor
      "start"
    end
  end

  class RightAlignedLabel < Label
    def left_edge
      @point.x - length
    end

    def text_anchor
      "end"
    end
  end

  class CentredLabel < Label
    def left_edge
      @point.x - length / 2
    end

    def text_anchor
      "middle"
    end
  end
end
