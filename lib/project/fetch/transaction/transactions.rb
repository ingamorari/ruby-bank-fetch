class Transaction

  def initialize(transaction)
    @date = transaction.div(class: "cp-time").text
    @description = transaction.td(class: ['TranDescription', 'td-action', 'with-hover', 'cp-export']).text
    @processingDate = transaction.td(class: ['td-action', 'with-hover', 'text-center', 'cp-export']).text
    @amount = transaction.td(class: ['tranListMoney', 'nowrap', 'td-action', 'with-hover', 'cp-no-export'], index: 1).text
    @commission = transaction.td(class: 'tranListFee').text

  end

  def to_hash
    {
        date: @date,
      description: @description,
      amount: @amount,
      commission: @commission,
    }
  end
end