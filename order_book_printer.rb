require 'pdf-reader'

# Function to extract text from a PDF page
def extract_text_from_page(pdf_file, page_number)
  reader = PDF::Reader.new(pdf_file)
  reader.pages[page_number].text
end

# Function to print PNG file
def print_png(png_file)
  puts("\nPrinting: #{png_file}")
  printer_name = "Canon_G7000_series"
  system("lp -d  #{printer_name} \"#{png_file}\" -o media=Custom.8x10in -o resolution=best -o InputSlot=Upper")  
end


# Main function
def main(pdf_file)
  # Iterate through each page of the PDF
  reader = PDF::Reader.new(pdf_file)
  reader.pages.each_with_index do |page, page_number|
    page_text = extract_text_from_page(pdf_file, page_number)

    # Extract song title from page text
    song_match = page_text.match(/Song: (.+)/)
    next unless song_match  # Skip to next page if no song found
    
    song_title = song_match[1].strip

    # Derive PNG filename from song title
    png_file = "#{song_title.downcase}.png"

    print_png(png_file)
  end
end

if __FILE__ == $PROGRAM_NAME
  pdf_file = "order_book.pdf"  # Replace with your PDF file
  main(pdf_file)
end
