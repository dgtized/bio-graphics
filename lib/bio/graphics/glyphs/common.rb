# 
# = bio/graphics/glyphs/common - common methods for all glyphs
#
# Copyright::   Copyright (C) 2007, 2008
#               Jan Aerts <jan.aerts@bbsrc.ac.uk>
#               Charles Comstock <dgtized@gmail.com>
# License::     The Ruby License
#

module Bio::Graphics::Glyph
  class Bio::Graphics::Glyph::Common
    def initialize(subfeature, feature_context)
      @subfeature, @feature_context = subfeature, feature_context
    end
    attr_accessor :subfeature, :feature_context

    def left_pixel
      raise "invalid subfeature" if @subfeature.pixel_range_collection.empty?
      return @subfeature.pixel_range_collection.map {|x| x.lend }.min
    end
    
    def right_pixel
      raise "invalid subfeature" if @subfeature.pixel_range_collection.empty?
      return @subfeature.pixel_range_collection.map {|x| x.rend }.max
    end
    
    private

    # Method to draw each of the squared spliced rectangles for
    # spliced and directed_spliced
    # ---
    # *Arguments*:
    # * _track_drawing_::
    # * _pixel_ranges_:: 
    # * _top_pixel_of_feature_:: 
    # * _gap_starts_:: 
    # * _gap_stops_:: 
    def draw_spliced(feature_context, pixel_ranges, gap_starts, gap_stops,
                     height = Bio::Graphics::FEATURE_HEIGHT)
      # draw the parts
      pixel_ranges.each do |range|
        y = height == Bio::Graphics::FEATURE_HEIGHT ? 0 : (Bio::Graphics::FEATURE_HEIGHT - height).to_f / 2
        feature_context.rectangle(range.lend, y, range.rend - range.lend, height).fill
        gap_starts.push(range.rend)
        gap_stops.push(range.lend)
      end

      # And then draw the connections in the gaps
      # Start with removing the very first start and the very last stop.
      gap_starts.sort!.pop
      gap_stops.sort!.shift

      gap_starts.length.times do |gap_number|
        connector(feature_context,gap_starts[gap_number].to_f,gap_stops[gap_number].to_f)
      end

      if @subfeature.hidden_subfeatures_at_stop
        feature_context.move_to(self.right_pixel, Bio::Graphics::FEATURE_ARROW_LENGTH)
        feature_context.line_to(@subfeature.feature.track.panel.width, Bio::Graphics::FEATURE_ARROW_LENGTH)
        feature_context.stroke
      end

      if @subfeature.hidden_subfeatures_at_start
        feature_context.move_to(1, Bio::Graphics::FEATURE_ARROW_LENGTH)
        feature_context.line_to(self.left_pixel, Bio::Graphics::FEATURE_ARROW_LENGTH)
        feature_context.stroke
      end
    end

    # Method to draw the arrows of directed glyphs. Not to be used
    # directly, but called by Feature#draw.
    def arrow(feature_context,direction,x,y,size)
      case direction
      when :right
        feature_context.move_to(x,y)
        feature_context.rel_line_to(size,size)
        feature_context.rel_line_to(-size,size)
        feature_context.close_path.fill
      when :left
        feature_context.move_to(x,y)
        feature_context.rel_line_to(-size,size)
        feature_context.rel_line_to(size,size)
        feature_context.close_path.fill
      when :north
        feature_context.move_to(x-size,y+size)
        feature_context.rel_line_to(size,-size)
        feature_context.rel_line_to(size,size)
        feature_context.close_path.fill
      when :south
        feature_context.move_to(x-size,y-size)
        feature_context.rel_line_to(size,size)
        feature_context.rel_line_to(size,-size)
        feature_context.close_path.fill
      end
    end

    # Method to draw the arrows of directed glyphs. Not to be used
    # directly, but called by Feature#draw.
    def open_arrow(feature_context,direction,x,y,size)
      case direction
      when :right
        feature_context.move_to(x,y)
        feature_context.rel_line_to(size,size)
        feature_context.rel_line_to(-size,size)
        feature_context.stroke
      when :left
        feature_context.move_to(x,y)
        feature_context.rel_line_to(-size,size)
        feature_context.rel_line_to(size,size)
        feature_context.stroke
      when :north
        feature_context.move_to(x-size,y+size)
        feature_context.rel_line_to(size,-size)
        feature_context.rel_line_to(size,size)
        feature_context.stroke
      when :south
        feature_context.move_to(x-size,y-size)
        feature_context.rel_line_to(size,size)
        feature_context.rel_line_to(size,-size)
        feature_context.stroke
      end
    end
    
    # Method to draw the connections (introns) of spliced glyphs. Not to
    # be used directly, but called by Feature#draw.
    def connector(feature_context,from,to)
      line_width = feature_context.line_width
      feature_context.set_line_width(0.5)
      middle = from + ((to - from)/2)
      feature_context.move_to(from, 2)
      feature_context.line_to(middle, 7)
      feature_context.line_to(to, 2)
      feature_context.stroke
      feature_context.set_line_width(line_width)
    end                    

  end
end
