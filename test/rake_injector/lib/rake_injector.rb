# Here's Rake namespace is introduced, however, `Rake.application` is not
# accessible, since `rake` command was not run.
module Rake
  module WeDontCareAboutThatModule
  end
end
