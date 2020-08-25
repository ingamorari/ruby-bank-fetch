require "watir"
require "selenium-webdriver"
require "json"
require "nokogiri"

class Fetch

  def initialize
    execute
  end

  def execute
    connect
    @accounts = []
    @browser.table(id: "contracts-list").rows(class: "cp-item").each do |tr|
      tr.click
      @accounts.push(fetch_account)
      @browser.back
      @browser.back
    end
    @browser.close
    write_file(@accounts)
  end

  def connect
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(chromeOptions: {detach: true})
    @browser = Watir::Browser.new(:chrome, desired_capabilities: caps)
    @browser.goto("https://demo.bank-on-line.ru/?registered=demo#Contracts")
  end

  def fetch_account
    account_data_table = @browser.table(class: "tblBlock").html
    account_data = parse_account(account_data_table)
    account_data[:transactions] = fetch_transactions
    account_data
  end

  def fetch_transactions
    @browser.li(class: "operhist").click
    @browser.div(inputid: "DateFrom").click
    @browser.a(class: "ui-datepicker-prev").click
    @browser.a(class: "ui-datepicker-prev").click
    @browser.a(class: "ui-state-default", text: Time.now.day.to_s).click
    @browser.span('data-action': "get-transactions").click
    transactions_data_table = @browser.table(class: "cp-tran-with-balance").html
    parse_transactions(transactions_data_table)
  end

  def parse_account(html)
    parsed_account_table = Nokogiri::HTML.fragment(html, "UTF-8")
    table_rows = parsed_account_table.css("tr")
    {
        name: table_rows[0].css(".caption-hint").text.to_i,
        currency: table_rows[1].css(".tdFieldVal").text.split(" ")[1],
        balance: table_rows[5].css(".tdFieldVal").text.to_s.split(" ").join("").to_f,
        created_at: Date.parse(table_rows[3].css(".tdFieldVal").text).strftime("%Y-%m-%d"),
        transactions: []
    }
  end

  def parse_transactions(html)
    parsed_transactions_table = Nokogiri::HTML.fragment(html, "UTF-8")
    transactions = []
    parsed_transactions_table.css("tr.cp-item.cp-transaction").each do |tr|
      transactions.push({
                            date: Date.parse(tr.css(".cp-time > text()").text).strftime("%Y-%m-%d"),
                            processingDate: Date.parse(tr.css(".td-action.with-hover.text-center.cp-export").text).strftime("%Y-%m-%d"),
                            description: tr.css(".TranDescription").text,
                            amount: tr.css(".tranListMoney")[1].text.to_s.split(" ").join("").to_f,
                            commission: tr.css(".tranListFee").to_s.split(" ").join("").to_f,
                        })

    end
    transactions
  end

  def write_file(accounts)
    File.open("./temp.json", "w") do |f|
      f.write(JSON.pretty_generate({ accounts: accounts }))
    end
  end
end
