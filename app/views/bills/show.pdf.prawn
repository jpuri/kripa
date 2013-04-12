prawn_document(:filename=>'Hello.pdf') do |pdf|
  pdf.text "Invoice"
  pdf.text @bill.customer.name
   
   for bill_part in @bill.bill_parts
     pdf.text bill_part.part.name + String(bill_part.quantity) + String(bill_part.price/bill_part.quantity) + String(bill_part.price)
   end
end