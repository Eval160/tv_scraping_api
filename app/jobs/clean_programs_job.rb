class CleanProgramsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    old_programs = Program.where("stop_time <= ?", Time.now)
    old_programs.destroy_all
  end
end
