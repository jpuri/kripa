prawn_document(:filename=>'Hello.pdf') do |pdf|
  
  pdf.text "Invoice"
  pdf.text @bill.customer.name
  pdf.move_down 20
 
  i = 1 
  data = Array.new
    for bill_part in @bill.bill_parts
      data.insert(0, [i, bill_part.part.name, String(bill_part.quantity), String(bill_part.price/bill_part.quantity), String(bill_part.price)])
      i = i + 1
    end
  t = pdf.make_table(data.reverse)
  
  t.draw
  
  pdf.bounding_box([400, 200], :width => 500, :height => 50) do
    pdf.text "Total" + String(@bill.total_cost)
  end

  pdf.bounding_box([0, 80], :width => 500, :height => 150) do
    pdf.text "Declaration :"
	pdf.text "We declaree that this invoice shows the actual price of the goods"
	pdf.text "described and that all particulars are ture and correct."

  end

  pdf.bounding_box([400, 80], :width => 500, :height => 150) do
    pdf.text "Archana"
	pdf.text "(Manager - Export)"
  end
end