# config/initializers/recurring_tasks.rb

return unless defined?(SolidQueue::RecurringTask)

schedule_file = Rails.root.join("config/recurring.yml")
if File.exist?(schedule_file)
  tasks = YAML.load_file(schedule_file)[Rails.env] || {}

  tasks.each do |task_key, definition|
    SolidQueue::RecurringTask.upsert(
      { task_key: task_key }.merge(definition.symbolize_keys),
      unique_by: :task_key
    )
  end
end
