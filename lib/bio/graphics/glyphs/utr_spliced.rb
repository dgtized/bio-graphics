# 
# = bio/graphics/glyphs/splices - utr splice glyph
#
# Copyright::   Copyright (C) 2007, 2008
#               Jan Aerts <jan.aerts@bbsrc.ac.uk>
#               Charles Comstock <dgtized@gmail.com>
# License::     The Ruby License
#

module Bio::Graphics::Glyph
  class Bio::Graphics::Glyph::UtrSpliced < Bio::Graphics::Glyph::Common
    def draw
      pixel_ranges = @subfeature.pixel_range_collection.sort_by{|pr| pr.lend}
      draw_spliced(@feature_context, pixel_ranges, [], [], 6)
    end
  end
end
