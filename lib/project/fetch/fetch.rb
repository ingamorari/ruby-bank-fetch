require_relative "../../project"
require "watir"
require "selenium-webdriver"
require "json"
require_relative "./accounts/account"

module Fetch
  caps = Selenium::WebDriver::Remote::Capabilities.chrome(:chromeOptions => {detach: true })
  b = Watir::Browser.new(:chrome, desired_capabilities: caps)
  b.goto("https://demo.bank-on-line.ru/?registered=demo#Contracts")

  File.open("./temp.json","w") do |f|
    accounts = []
    tempHash = {
        accounts: []
    }
    b.table(id: "contracts-list").rows('data-guid': "aclUZJSYY3GD5EZJGWTH7FYXRK2PI").each do |tr|
      tr.click
      accounts.push(Account::new(b).return)
      b.back
      b.back
    end
    tempHash[:accounts] = accounts
    f.write(JSON.pretty_generate(tempHash))
  end
  b.close
end