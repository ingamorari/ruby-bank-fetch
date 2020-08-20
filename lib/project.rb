# frozen_string_literal: true

require "project/version"
require "constants/constants"
require 'watir'
require 'selenium-webdriver'
module Project
  class Error < StandardError;
  end
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(:chromeOptions => {detach: true })
  b = Watir::Browser.new(:chrome, desired_capabilities: caps)
  b.goto("https://facebook.com")
end
