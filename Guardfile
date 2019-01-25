def report_detected_file(file)
  puts "\033[1mDetected change for #{file}\033[0m"
end

guard :shell do
  watch(/(.*)([^(\.pp)]\.md|\.eps)$/) do |m|
    report_detected_file(m[0])
    `rake build`
  end

#  watch(/fig\/(.*)\.png/) { |m| `rake eps` } # TODO: 変更されたファイルだけを対象にする
#  watch(/(.*)\.plt/) { |m| `rake plot` } # TODO: 変更されたファイルだけを対象にする
end
