class Theorist::Note
  def self.natural_note_names
    ['A', 'B', 'C', 'D', 'E', 'F', 'G']
  end

  def self.sharp_note_names
    (natural_note_names - ['B', 'E']).map {|name| "#{name}#" }
  end

  def self.flat_note_names
    (natural_note_names - ['C', 'F']).map {|name| "#{name}b" }
  end

  def self.accidental_note_names
    sharp_note_names + flat_note_names
  end

  def self.all_names
    natural_note_names + accidental_note_names
  end

  all_names.each do |the_name|
    define_method("#{the_name}?") do
      !name.nil? && @names.include?(the_name)
    end
  end

  def self.all
    all_names.map {|name| new(name) }.uniq {|note| note.names.sort }
  end

  def self.naturals
    natural_note_names.map {|note_name| new(note_name) }
  end

  def self.sharps
    sharp_note_names.map {|note_name| new(note_name) }
  end

  def self.flats
    flat_note_names.map {|note_name| new(note_name) }
  end

  attr_reader :names

  def initialize(name)
    @names = [name] + alternate_names_for_name(name)
  end

  def name
    @names.first
  end

  def ==(note)
    return false if !note.is_a?(Theorist::Note)
    @names.sort == note.names.sort
  end

  def +(semitones)
    chromatic_scale = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    chromatic_scale = chromatic_scale.map {|note_name| Theorist::Note.new(note_name) }

    my_index = chromatic_scale.index {|note| note == self }
    next_index = my_index + (semitones % chromatic_scale.count)

    chromatic_scale[next_index]
  end

private

  def alternate_names_for_name(name)
    Array(alternate_note_name_map[name])
  end

  def alternate_note_name_map
    map = {
      'Ab' => 'G#',
      'Bb' => 'A#',
      'Db' => 'C#',
      'Eb' => 'D#',
      'Gb' => 'F#'
    }
    reversed_map = map.inject({}) {|m,(k,v)| m[v] = k; m }

    map.merge(reversed_map)
  end
end
