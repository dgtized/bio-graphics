require File.dirname(__FILE__) + '/../lib/bio-graphics'

#Initialize graphic for a nucleotide sequence of 4173015 bp, zooming in on the
#region 11111..3333333
my_panel = Bio::Graphics::Panel.new(4173015, 1000, true, 11111, 3333333)
#my_panel = Bio::Graphics::Panel.new(4173015, 800, false, 1, 4173015)

#Create and configure tracks
scaffold_track = my_panel.add_track('scaffold', false)
marker_track = my_panel.add_track('marker', true)
clone_track = my_panel.add_track('clone', false)

scaffold_track.colour = [1,0,0]
marker_track.colour = [0,1,0]
marker_track.glyph = :triangle
clone_track.colour = [0,0,1]

# Add data to tracks
File.open('data.txt').each do |line|
  line.chomp!
  accession, type, start, stop = line.split(/\t/)
  if type == 'scaffold'
    if start.nil?
      scaffold_track.add_feature(Bio::Feature.new('scaffold', '1..4173015'), accession)
    else
      scaffold_track.add_feature(Bio::Feature.new('scaffold', start + '..' + stop), accession, 'http://www.google.com')
    end
    
  elsif type == 'marker'
    marker_track.add_feature(Bio::Feature.new('marker', ((start.to_i + stop.to_i)/2).to_s), accession, 'http://www.thearkdb.org/arkdb/do/getMarkerDetail?accession=' + accession)
  elsif type == 'clone'
    clone_track.add_feature(Bio::Feature.new('clone', start + '..' + stop), accession)
  end
end

# And draw
my_panel.draw('my_panel.png')
