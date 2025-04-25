class HelloJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Rails.logger.info "🎉 HelloJob is running with args: #{args.inspect}"
  end
end
