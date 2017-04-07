module DebuggingHelpers
  def debug
    save_and_open_page
  end

  def screenshot(html: false, cmd: "imgcat")
    path = Rails.root.join("tmp",
                           "capybara",
                           "#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}.png")

    save_screenshot(path, full: false) if respond_to?(:save_screenshot)
    puts `#{cmd} "#{path}"`
    puts "Saved image to: #{path}"
    save_and_open_page if html && respond_to?(:save_and_open_page)
  end
end

RSpec.configure do |config|
  config.include DebuggingHelpers
end
