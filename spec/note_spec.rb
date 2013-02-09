require 'theorist/note'

describe Theorist::Note do
  describe "+" do
    chromatic_scale = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']

    (1..12).each do |semitones|
      it "should return the note #{semitones} semitones up when the operand is #{semitones}" do
        start = Theorist::Note.new(chromatic_scale[0])
        expected_result = Theorist::Note.new(chromatic_scale[semitones % 12])
        result = start + semitones

        result.should eq(expected_result)
      end
    end
  end

  describe "==" do
    [
      ['Ab', 'G#'],
      ['Bb', 'A#'],
      ['Db', 'C#'],
      ['Eb', 'D#'],
      ['Gb', 'F#']
    ].each do |names|
      it "should return true for #{names[0]} and #{names[1]}" do
        note1 = Theorist::Note.new(names[0])
        note2 = Theorist::Note.new(names[1])
        result = note1 == note2

        result.should be_true
      end
    end
  end

  describe ".accidental_note_names" do
    let(:note_names) { Theorist::Note.accidental_note_names }

    (Theorist::Note.sharp_note_names + Theorist::Note.flat_note_names).each do |name|
      it "should include #{name}" do
        note_names.should include(name)
      end
    end
  end

  describe ".natural_note_names" do
    let(:note_names) { Theorist::Note.natural_note_names }

    ['A', 'B', 'C', 'D', 'E', 'F', 'G'].each do |name|
      it "should include #{name}" do
        note_names.should include(name)
      end
    end
  end

  describe ".sharp_note_names" do
    let(:note_names) { Theorist::Note.sharp_note_names }

    ['A#', 'C#', 'D#', 'F#', 'G#'].each do |name|
      it "should include #{name}" do
        note_names.should include(name)
      end
    end
  end

  describe ".flat_note_names" do
    let(:note_names) { Theorist::Note.flat_note_names }

    ['Ab', 'Bb', 'Db', 'Eb', 'Gb'].each do |name|
      it "should include #{name}" do
        note_names.should include(name)
      end
    end
  end

  describe ".all_names" do
    let(:note_names) { Theorist::Note.all_names }

    [
      'A', 'Ab', 'A#',
      'B', 'Bb',
      'C', 'C#',
      'D', 'D#', 'Db',
      'E', 'Eb',
      'F', 'F#',
      'G', 'Gb', 'G#'
    ].each do |name|
      it "should include #{name}" do
        note_names.should include(name)
      end
    end
  end

  describe ".all" do
    let(:notes) { Theorist::Note.all }

    it "should be of length 12" do
      notes.count eq(12)
    end

    Theorist::Note.all_names.each do |name|
      it "should contain one #{name}" do
        notes.select {|note| note.send("#{name}?") }.count.should eq(1)
      end
    end
  end

  describe ".naturals" do
    let(:note_names) { notes.map(&:name) }
    let(:notes) { Theorist::Note.naturals }

    Theorist::Note.natural_note_names.each do |note_name|
      it "should include an instance whose name is #{note_name}" do
        note_names.should include(note_name)
      end
    end
  end

  describe ".sharps" do
    let(:note_names) { notes.map(&:name) }
    let(:notes) { Theorist::Note.sharps }

    Theorist::Note.sharp_note_names.each do |note_name|
      it "should include an instance whose name is #{note_name}" do
        note_names.should include(note_name)
      end
    end
  end

  describe ".flats" do
    let(:note_names) { notes.map(&:name) }
    let(:notes) { Theorist::Note.flats }

    Theorist::Note.flat_note_names.each do |note_name|
      it "should include an instance whose name is #{note_name}" do
        note_names.should include(note_name)
      end
    end
  end
end
