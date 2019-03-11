require 'thread'

class MultiThreadSingleton
  private_class_method :new
  @mutex = Mutex.new
  @@instance = nil

   def self.instance
     if @@instance.nil?
       @mutex.synchronize do
         @@instance = new unless @@instance
       end
     end
     @@instance
   end

end


