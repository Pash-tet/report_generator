require_relative 'report_generator'

ReportGenerator.new(path: ENV['FILENAME']).call
