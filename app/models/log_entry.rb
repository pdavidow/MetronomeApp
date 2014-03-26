class LogEntry < Object
  include Mongoid::Document
  # include Mongoid::Timestamps::Created  ### doesn't seem to work for embedded doc

  field :contents, type: String, default: ''
  field :time, type: Time, default: ->{Time.now}

  embedded_in :log

  def index
    self.log.entries.index(self)
  end

  def display_index
    self.index + User::DISPLAY_INDEX_OFFSET
  end
end