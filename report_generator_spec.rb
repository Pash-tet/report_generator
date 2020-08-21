require_relative 'report_generator'
require 'json'
require 'minitest/autorun'
require "minitest/benchmark" if ENV["BENCH"]

describe ReportGenerator do
  before do
    File.write('result.json', '')
    File.write('data_test.txt', 'user,0,Hazel,Margarete,19
session,0,0,Internet Explorer 50,81,2018-02-01
session,0,1,Safari 27,88,2017-10-28
session,0,2,Firefox 13,92,2016-11-02
session,0,3,Internet Explorer 40,37,2017-05-31
session,0,4,Internet Explorer 16,37,2017-11-21
session,0,5,Safari 19,22,2017-11-30
session,0,6,Chrome 31,74,2016-08-22
session,0,7,Firefox 46,76,2019-02-04
user,1,Wilfredo,Louetta,40
session,1,0,Firefox 38,68,2018-04-24
session,1,1,Internet Explorer 41,27,2016-09-06
session,1,2,Internet Explorer 1,74,2017-01-05
session,1,3,Firefox 47,28,2017-06-09
session,1,4,Internet Explorer 22,98,2016-11-03
user,2,Cecil,Rosalba,44
session,2,0,Safari 26,96,2018-08-20
session,2,1,Internet Explorer 10,3,2019-01-03
session,2,2,Internet Explorer 47,52,2016-07-31
session,2,3,Safari 34,37,2017-09-14
session,2,4,Internet Explorer 17,22,2016-07-10
session,2,5,Firefox 26,76,2017-02-06
session,2,6,Chrome 14,88,2017-02-19
session,2,7,Safari 31,113,2018-04-12
session,2,8,Chrome 20,72,2016-09-04
session,2,9,Safari 13,14,2017-07-26
user,3,Kieth,Noble,20
session,3,0,Safari 23,1,2018-02-19
session,3,1,Internet Explorer 24,92,2018-05-15
session,3,2,Chrome 6,91,2017-01-06
session,3,3,Internet Explorer 47,7,2016-09-01
session,3,4,Firefox 4,20,2017-03-22
session,3,5,Internet Explorer 23,17,2016-12-02
session,3,6,Internet Explorer 5,91,2017-12-29
session,3,7,Internet Explorer 23,2,2017-03-17')
  end

  it 'return success result' do
    ReportGenerator.new(path: 'data_test.txt').call
    expected_result = {"totalUsers"=>4, "uniqueBrowsersCount"=>29, "totalSessions"=>31, "allBrowsers"=>"CHROME 14, CHROME 20, CHROME 31, CHROME 6, FIREFOX 13, FIREFOX 26, FIREFOX 38, FIREFOX 4, FIREFOX 46, FIREFOX 47, INTERNET EXPLORER 1, INTERNET EXPLORER 10, INTERNET EXPLORER 16, INTERNET EXPLORER 17, INTERNET EXPLORER 22, INTERNET EXPLORER 23, INTERNET EXPLORER 24, INTERNET EXPLORER 40, INTERNET EXPLORER 41, INTERNET EXPLORER 47, INTERNET EXPLORER 5, INTERNET EXPLORER 50, SAFARI 13, SAFARI 19, SAFARI 23, SAFARI 26, SAFARI 27, SAFARI 31, SAFARI 34", "usersStats"=>{"Hazel Margarete"=>{"sessionCount"=>8, "totalTime"=>"507 min.", "longestSession"=>"92 min.", "browsers"=>"Chrome 31, Firefox 13, Firefox 46, Internet Explorer 16, Internet Explorer 40, Internet Explorer 50, Safari 19, Safari 27", "usedIE"=>true, "alwaysUsedChrome"=>false, "dates"=>"2019-02-04, 2018-02-01, 2017-11-30, 2017-11-21, 2017-10-28, 2017-05-31, 2016-11-02, 2016-08-22"}, "Wilfredo Louetta"=>{"sessionCount"=>5, "totalTime"=>"295 min.", "longestSession"=>"98 min.", "browsers"=>"Firefox 38, Firefox 47, Internet Explorer 1, Internet Explorer 22, Internet Explorer 41", "usedIE"=>true, "alwaysUsedChrome"=>false, "dates"=>"2018-04-24, 2017-06-09, 2017-01-05, 2016-11-03, 2016-09-06"}, "Cecil Rosalba"=>{"sessionCount"=>10, "totalTime"=>"573 min.", "longestSession"=>"113 min.", "browsers"=>"Chrome 14, Chrome 20, Firefox 26, Internet Explorer 10, Internet Explorer 17, Internet Explorer 47, Safari 13, Safari 26, Safari 31, Safari 34", "usedIE"=>true, "alwaysUsedChrome"=>false, "dates"=>"2019-01-03, 2018-08-20, 2018-04-12, 2017-09-14, 2017-07-26, 2017-02-19, 2017-02-06, 2016-09-04, 2016-07-31, 2016-07-10"}, "Kieth Noble"=>{"sessionCount"=>8, "totalTime"=>"321 min.", "longestSession"=>"92 min.", "browsers"=>"Chrome 6, Firefox 4, Internet Explorer 23, Internet Explorer 23, Internet Explorer 24, Internet Explorer 47, Internet Explorer 5, Safari 23", "usedIE"=>true, "alwaysUsedChrome"=>false, "dates"=>"2018-05-15, 2018-02-19, 2017-12-29, 2017-03-22, 2017-03-17, 2017-01-06, 2016-12-02, 2016-09-01"}}}

    _(expected_result).must_equal JSON.parse(File.read('result.json'))
  end
end