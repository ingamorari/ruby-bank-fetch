require_relative "../transaction/transactions"

class Account

  def initialize(b)
    @name = b.table(class: ["tblBlock", "tbl-inform"]).tr(class: "trHeader").div(class: "caption-hint").text
    @currency = b.table(class: ["tblBlock", "tbl-inform"]).tr(index: 2).td(class: "tdFieldVal").text
    @balance = b.table(class: ["tblBlock", "tbl-inform"]).tr(index: 5).td(class: "tdFieldVal").text
    @nature = b.table(class: ["tblBlock", "tbl-inform"]).tr(index: 1).td(class: "tdFieldVal").text
    @transactions = []
    b.li(class: ["pic", "operhist", "cp-action"]).click
    b.div(inputid: "DateFrom").click
    currentDate = Time.now.day
    b.a(class: ["ui-datepicker-prev", "ui-corner-all"]).click
    b.a(class: ["ui-datepicker-prev", "ui-corner-all"]).click
    b.a(class: "ui-state-default", text: currentDate.to_s).click
    b.span('data-action': "get-transactions").click

    b.table(class: "cp-tran-with-balance").rows(class: [/cp-item/, /cp-transaction/]).each do |transaction|
      @transactions.push(Transaction.new(transaction).return)
    end
  end

  def return
    {
        name: @name,
        currency: @currency,
        balance: @balance,
        nature: @nature,
        transactions: @transactions,
    }
  end
end