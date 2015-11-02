class Notification
  attr_accessor :message, :link

  def initialize(options)
    @message = options[:message]
    @link = options[:link]
  end
end
