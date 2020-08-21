require_relative "../transaction/transactions"

class Account

  def initialize(browser)
    @name = browser.table(class: "tblBlock").tr(class: "trHeader").div(class: "caption-hint").text
    @currency = browser.table(class: "tblBlock").tr(index: 2).td(class: "tdFieldVal").text
    @balance = browser.table(class: "tblBlock").tr(index: 5).td(class: "tdFieldVal").text
    @nature = browser.table(class: "tblBlock").tr(index: 1).td(class: "tdFieldVal").text
    @transactions = []
    browser.li(class: "operhist").click
    browser.div(inputid: "DateFrom").click
    currentDate = Time.now.day
    browser.a(class: "ui-datepicker-prev").click
    browser.a(class: "ui-datepicker-prev").click
    browser.a(class: "ui-state-default", text: currentDate.to_s).click
    browser.span('data-action': "get-transactions").click

    browser.table(class: "cp-tran-with-balance").rows(class: "cp-transaction").each do |transaction|
      @transactions.push(Transaction.new(transaction).to_hash)
    end
  end

  def to_hash
    {
        name: @name,
        currency: @currency,
        balance: @balance.to_s.split(' ').join('').to_f,
        nature: @nature,
        transactions: @transactions,
    }
  end
end