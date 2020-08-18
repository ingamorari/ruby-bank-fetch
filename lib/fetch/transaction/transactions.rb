class Transaction

  def initialize(transaction)
    @operationDate = transaction.div(class: 'cp-time').text
    @description = transaction.td(class: ['TranDescription', 'td-action', 'with-hover', 'cp-export']).text
    @processingDate = transaction.td(class: ['td-action', 'with-hover', 'text-center', 'cp-export']).text
    @reserved = transaction.td(class: ['tranListMoney', 'nowrap', 'td-action', 'with-hover', 'cp-no-export'], index: 0).text
    @amount = transaction.td(class: ['tranListMoney', 'nowrap', 'td-action', 'with-hover', 'cp-no-export'], index: 1).text
    @commission = transaction.td(class: 'tranListFee').text
  end

  def return
    {
        operationDate: @operationDate,
        description: @description,
        reserved: @reserved,
        amount: @amount,
        commission: @commission,
    }
  end
end