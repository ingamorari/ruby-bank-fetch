require_relative "../../project"
require "watir"
require "selenium-webdriver"
require "json"
require_relative "./accounts/account"

module Fetch
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(:chromeOptions => {detach: true })
  browser = Watir::Browser.new(:chrome, desired_capabilities: caps)
  browser.goto("https://demo.bank-on-line.ru/?registered=demo#Contracts")

  File.open("./temp.json", "w") do |f|
    accounts = []
    tempHash = {
      accounts: []
    }
    browser.table(id: "contracts-list").rows(class: "cp-item").each do |tr|
      tr.click
      accounts.push(Account::new(browser).to_hash)
      browser.back
      browser.back
    end
    tempHash[:accounts] = accounts
    f.write(JSON.pretty_generate(tempHash))
  end
  browser.close
end
