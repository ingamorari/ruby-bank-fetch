require_relative "../lib/project/fetch/fetch"

RSpec.describe Fetch do
  context "class Fetch" do
    fetch = Fetch.new
    it "Check an example account" do
      html_example = Nokogiri::HTML(File.read("account_table.html"))
      account = fetch.parse_account(html_example)
      puts account
      expect(account).to eq({
                                "name" => 40817810200000055320,
                                "currency" => "RUB",
                                "balance" => 1000000.0,
                                "created_at" => "2019-08-01",
                                "transactions" => []
                            })
    end

    it "Check number of transactions and show an example account" do
      html_example = Nokogiri::HTML(File.read("transactions_table.html"))
      transactions = fetch.parse_transactions(html_example)

      expect(transactions.count).to eq(5)
      expect(transactions[0]).to eq({
                                        "date" => "2020-08-20",
                                        "processingDate" => "2020-08-20",
                                        "description" => "Оплата услуг МегаФон Урал, Номер телефона: 79111111111, 20.08.2020 11:59:59, Сумма 50.00 RUB, Банк-он-ЛайнСтатусУспешно Тип операцииОплата услугСумма операции50.00 ₽Проведено50.00 ₽Комиссия0.00 ₽Дата обработки20.08.2020Информация о терминалеBank-on-line, Россия, Ekaterinburg, ul. Chapaeva 3aОписаниеОплата услуг МегаФон Урал, Номер телефона: 79111111111, 20.08.2020 11:59:59, Сумма 50.00 RUB, Банк-он-ЛайнНомер телефона9111111111",
                                        "amount" => 50.0,
                                        "commission" => 0.0
                                    })
    end
  end
end
