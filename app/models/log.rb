class Log < Object
  include Mongoid::Document

  embedded_in :piece
  embeds_many :entries, class_name: 'LogEntry'

  def initialize_copy
    self.entries = self.entries.clone
  end
end