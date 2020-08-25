require_relative "../lib/project/fetch/fetch"
require "nokogiri"
RSpec.describe Fetch do
  context "class Fetch" do
    fetch = Fetch.new
    it "Check an example account" do
      html_example = Nokogiri::HTML(File.read("account_table.html"))
      account = fetch.parse_account(html_example.to_s)
      puts account
      expect(account).to eq({
                              :name => 40817978300000055322,
                              :currency => "EUR",
                              :balance => 100000.0,
                              :created_at => "2019-08-01",
                              :transactions => []
                            })
    end

    it "Check number of transactions and show an example account" do
      html_example = Nokogiri::HTML(File.read("transactions_table.html"))
      transactions = fetch.parse_transactions(html_example.to_s)
      puts transactions[0]
      expect(transactions.count).to eq(5)
      expect(transactions[0]).to eq({
                                        :date => "2020-08-20",
                                        :processingDate => "2020-08-20",
                                        :description => "Оплата услуг МегаФон Урал, Номер телефона: 79111111111, 20.08.2020 11:59:59, Сумма 50.00 RUB, Банк-он-Лайн\n\n\nСтатус\nУспешно \n\n\nТип операции\nОплата услуг\n\n\n\nСумма операции\n50.00 ₽\n\n\n\nПроведено\n50.00 ₽\n\n\nКомиссия\n0.00 ₽\n\n\nДата обработки\n20.08.2020\n\n\nИнформация о терминале\nBank-on-line, Россия, Ekaterinburg, ul. Chapaeva 3a\n\n\nОписание\nОплата услуг МегаФон Урал, Номер телефона: 79111111111, 20.08.2020 11:59:59, Сумма 50.00 RUB, Банк-он-Лайн\n\n\nНомер телефона\n9111111111\n\n\n\n\n",
                                        :amount => 50.0,
                                        :commission => 0.0
                                    })
    end
  end
end
