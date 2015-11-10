# Class that write report for multiple formats, this will get really messy in the future
# class Report
#   def initialize
#     @title = 'Monthly Report'
#     @text =  ['Things are going', 'really, really well.']
#   end
#   def output_report(format)
#     if format == :plain
#       puts("*** #{@title} ***")
#     elsif format == :html
#       puts('<html>')
#       puts('  <head>')
#       puts("    <title>#{@title}</title>")
#       puts('  </head>')
#       puts('  <body>')
#     else
#       raise "Unknown format: #{format}"
#     end
#     @text.each do |line|
#       if format == :plain
#         puts(line)
#       else
#         puts("    <p>#{line}</p>" )
#       end
#     end
#     if format == :html
#       puts('  </body>')
#       puts('</html>')
#     end
#   end
# end
# Solution use inheritance and the template pattern so you should get what is the same and
# extract to a base class and make the res of the class inherit from this one

class Report
  def initialize
    @title = "Monthly Report"
    @text = ["Things are going", "really well"]
  end

  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_body
    @text.each do |line|
      output_line(line)
    end
  end

  def output_start
    raise 'Called abstract method: output_start'
  end

  def output_head
    raise 'Called abstract method: output_head'
  end

  def output_body
    raise 'Called abstract method: output_body'
  end

  def output_body_end
    raise 'Called abstract method: output_body_end'
  end

  def output_line(line)
    raise 'Called abstract method: output_line'
  end

  def output_end
    raise 'Called abstract method: output_end'
  end
end

class HTMLReport < Report
  def output_start
    puts('<html>')
  end

  def output_head
    puts('  <head>')
    puts("    <title>#{@title}</title>")
    puts('  </head>')
  end

  def output_body_start
    puts('<body>')
  end

  def output_line(line)
    puts("  <p>#{line}</p>")
  end

  def output_body_end
    puts('</body>')
  end

  def output_end
    puts('</html>')
  end
end

class PlainReport < Report
  def output_start
  end

  def output_head
    puts("*******#{@title}*******")
    puts
  end

  def output_body_start
  end

  def output_line(line)
    puts(line)
  end

  def output_body_end
  end

  def output_end
  end
end

# report_html  = HTMLReport.new.output_report
# report_plain = PlainReport.new.output_report


