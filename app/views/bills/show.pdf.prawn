prawn_document(:filename=>'Hello.pdf') do |pdf|
  pdf.text "welcome to pdf"
  pdf.text @bill.customer.name
   pdf.text "Pdf template not yet created" * 100
end