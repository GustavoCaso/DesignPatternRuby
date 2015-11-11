## Replacing the Algorithm with The Strategy
With this pattern we are avoiding **Inheritance** and using **Delegation**
It is simpler to change at runtime the `Formatter` and to create a new, just ny creating a `Formatter` that respond_to `output_report`
```ruby
class Formatter
  def output_report(title, text)
    raise 'Abstract method :output_report'
  end
end

class HTMLFormatter < Formatter
  def output_report(title, text)
    puts('<html>')
    puts('  <head>')
    puts("    <title>#{title}</title>")
    puts('  </head>')
    puts('  <body>')
    text.each do |line|
      puts("    <p>#{line}</p>" )
    end
    puts('  </body>')
    puts('</html>')
  end
end

class PlainTextFormatter < Formatter
  def output_report(title, text)
    puts("***** #{title} *****")
    text.each do |line|
      puts(line)
    end
  end
end


class Report
  attr_reader :text, :title
  attr_accessor :formatter

  def initialize(formatter)
    @text = ["Hello World", 'Foo Bar']
    @title = "Strategy Pattern"
    @formatter = formatter
  end

  def output_report
    formatter.output_report(title, text)
  end
end
```

In this example the `Report` class is in charge of passing all the necessary variable,
but it could pass itself as a context and the format will pick the values that it need.
In that case the variable flow will be less, the Report class And the formatter will be more couple.

```ruby
report = Report.new(HTMLFormatter.new)
report.output_report
```

We could impelement the **Stragtegy** pattern with `Proc` instead of classes,
that way we could create Reports out of thin air. T
This way we could create an interface than accepts a block:

```ruby
class ReportWithBlocks
  attr_reader :text, :title
  attr_accessor :formatter

  def initialize(&formatter)
    @text = ["Hello World", 'Foo Bar']
    @title = "Strategy Pattern"
    @formatter = formatter
  end

  def output_report
    formatter.call(self)
  end
end

html_reporter = -> do |context|
  puts('<html>')
  puts('  <head>')
  puts("    <title>#{context.title}</title>")
  puts('  </head>')
  puts('  <body>')
  context.text.each do |line|
    puts("    <p>#{line}</p>" )
  end
  puts('  </body>')
  puts('</html>')
end

report = ReportWithBlocks.new(&html_reporter).output_report
```

Or we could pass a `block` to the `initializer` of `ReportWithBlocks
```ruby
report = Report.new do |context|
  puts("***** #{context.title} *****")
  context.text.each do |line|
    puts(line)
  end
end.output_report
```
