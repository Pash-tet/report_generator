# frozen_string_literal: true

require 'date'
require 'json'

# Class generates file report.json with struct information from text file
class ReportGenerator
  attr_reader :path, :sessions, :users

  def initialize(path:)
    @sessions = []
    @users = []
    @path = path
  end

  def call
    parse_file
    generate_report
  end

  private

  def parse_file
    file = File.foreach(path)

    file&.each_entry do |line|
      attrs = line.split(',')

      if attrs[0] == 'session'
        last_user = @users.last
        session = {
          user_id: attrs[1],
          id: attrs[2],
          browser: attrs[3],
          time: attrs[4].to_i,
          date: Date.strptime(attrs[5], '%Y-%m-%d')
        }
        last_user[:sessions] << session if last_user[:id] == attrs[1]
        @sessions << session
      elsif attrs[0] == 'user'
        @users << { id: attrs[1], first_name: attrs[2], last_name: attrs[3], age: attrs[4], sessions: [] }
      else
        next
      end
    end
  end

  def generate_report
    user_info = {}

    users.each { |user| user_info.merge!("#{user[:first_name]} #{user[:last_name]}" => user_stats(user)) }

    File.write('result.json', overall_info.merge!(usersStats: user_info).to_json)
  end

  def overall_info
    uniq_browsers = @sessions.map { |s| s[:browser] }.uniq

    {
      totalUsers: users.count,
      uniqueBrowsersCount: uniq_browsers.count,
      totalSessions: @sessions.count,
      allBrowsers: uniq_browsers.map(&:upcase).sort.join(', ')
    }
  end

  def user_stats(user)
    user_sessions = user[:sessions].empty? ? @sessions.select { |s| s[:user_id] == user[:id] } : user[:sessions]
    sessions_periods = user_sessions.map { |s| s[:time] }
    sessions_browsers = user_sessions.map { |s| s[:browser] }.sort

    {
      sessionCount: user_sessions.count,
      totalTime: "#{sessions_periods.sum} min.",
      longestSession: "#{sessions_periods.max} min.",
      browsers: sessions_browsers.join(', '),
      usedIE: sessions_browsers.any? { |b| b.upcase.include?('INTERNET EXPLORER') },
      alwaysUsedChrome: sessions_browsers.all? { |b| b.upcase.include?('CHROME') },
      dates: user_sessions.map { |s| s[:date] }.sort.map(&:to_s).reverse.join(', ')
    }
  end
end
