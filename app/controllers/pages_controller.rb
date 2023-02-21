class PagesController < ApplicationController
  def home; end

  def download
    pdf = Prawn::Document.new
    pdf.text "Hello"

    send_data(
      pdf.render,
      filename: 'hello.pdf',
      type: 'application.pdf'
    )
  end

  def preview
    pdf = Prawn::Document.new
    pdf.text "This is a preview"
    pdf.text "It's only shows up in the preview route"
    pdf.start_new_page
    pdf.text "This is a new page"

    100.times do |i|
      pdf.text "This is line #{i}"
    end

    send_data(
      pdf.render,
      filename: 'hello.pdf',
      type: 'application.pdf',
      desposition: 'inline'
    )
  end
end
