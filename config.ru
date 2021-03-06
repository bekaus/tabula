# encoding: UTF-8
require_relative './webapp/tabula_settings.rb'
require_relative './webapp/tabula_web.rb'
run Cuba

# if running as a jar, automatically open the user's web browser
# (only if running under a desktop environment)
if "#{$PROGRAM_NAME}".include?("tabula.jar") && java.awt.Desktop.isDesktopSupported
  require 'java'
  # don't do "java_import java.net.URI" -- it conflicts with Ruby URI and
  # makes Cuba/Rack really really upset. just call "java.*" classes
  # directly.
  port = java.lang.Integer.getInteger('jetty.port', 8080)
  url = "http://127.0.0.1:#{port}"

  puts "\n======================================================"
  puts "Launching web browser to #{url}\n\n"
  puts "When you're done using the Tabula interface, you may"
  puts "return to this window and press \"Control-C\" to close it."
  puts "======================================================\n\n"

  # Open browser after slight delay. (The server may take a while to actually
  # serve HTTP, so we are trying to avoid a "Could Not Connect To Server".)
  uri = java.net.URI.new(url)
  sleep 0.5
  java.awt.Desktop.getDesktop().browse(uri)
end
