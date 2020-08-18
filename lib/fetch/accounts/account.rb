class Account

  def initialize(b)
    @name = b.table(class: ['tblBlock', 'tbl-inform']).tr(class: 'trHeader').div(class: 'caption-hint').text
    @currency = b.table(class: ['tblBlock', 'tbl-inform']).tr(index: 2).td(class: 'tdFieldVal').text
    @balance = b.table(class: ['tblBlock', 'tbl-inform']).tr(index: 5).td(class: 'tdFieldVal').text
    @nature = b.table(class: ['tblBlock', 'tbl-inform']).tr(index: 1).td(class: 'tdFieldVal').text
    @transactions = []
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