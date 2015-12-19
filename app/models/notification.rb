class Notification
  attr_accessor :message, :link, :class

  def initialize(options)
    @message = options[:message]
    @link = options[:link]
    @class = options[:class]
  end
end
