require '../lib/bio-graphics'

my_panel = Bio::Graphics::Panel.new(500, 1000, false)

generic_track = my_panel.add_track('generic', false)
line_track = my_panel.add_track('line', false, [0,0,1], :line)
line_with_handles_track = my_panel.add_track('line_with_handles', false, [1,0,0], :line_with_handles)
directed_track = my_panel.add_track('directed', false, [0,1,0], :directed_generic)
triangle_track = my_panel.add_track('triangle', false, [1,0,0], :triangle)
spliced_track = my_panel.add_track('spliced', false, [1,0,0], :spliced)
directed_spliced_track = my_panel.add_track('directed_spliced', false, [1,0,1], :directed_spliced)

generic_track.add_feature(Bio::Feature.new('clone', '250..375', 'http://www.newsforge.com'))
generic_track.add_feature(Bio::Feature.new('clone', '54..124', 'http://www.thearkdb.org'))
generic_track.add_feature(Bio::Feature.new('clone', '100..449', 'http://www.google.com'))

line_track.add_feature(Bio::Feature.new('utr', 'complement(200..320)'))
line_track.add_feature(Bio::Feature.new('utr', '355..480', 'http://www.zdnet.co.uk'))

line_with_handles_track.add_feature(Bio::Feature.new('utr', 'complement(200..320)'))
line_with_handles_track.add_feature(Bio::Feature.new('utr', '355..480', 'http://www.zdnet.co.uk'))

directed_track.add_feature(Bio::Feature.new('primer', '50..60', 'http://www.google.com'))
directed_track.add_feature(Bio::Feature.new('primer', 'complement(80..120)', 'http://www.sourceforge.net'))

triangle_track.add_feature(Bio::Feature.new('snp', '56'))
triangle_track.add_feature(Bio::Feature.new('snp', '103','http://digg.com'))

spliced_track.add_feature(Bio::Feature.new('spliced', 'join(34..52,109..183)','http://news.bbc.co.uk'))
spliced_track.add_feature(Bio::Feature.new('spliced', 'complement(join(170..231,264..299,350..360,409..445))'))
spliced_track.add_feature(Bio::Feature.new('spliced', 'join(134..152,209..283)'))

directed_spliced_track.add_feature(Bio::Feature.new('cds', 'join(34..52,109..183)', 'http://www.vrtnieuws.net'))
directed_spliced_track.add_feature(Bio::Feature.new('cds', 'complement(join(170..231,264..299,350..360,409..445))', 'http://bioinformatics.roslin.ac.uk'))
directed_spliced_track.add_feature(Bio::Feature.new('cds', 'join(134..152,209..283)'))

my_panel.draw('glyph_showcase.png')
