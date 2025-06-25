require "google_drive"

class GoogleSheet
  def initialize
    session = GoogleDrive::Session.from_service_account_key(
      ENV["GOOGLE_APPLICATION_CREDENTIALS"]
    )
    spreadsheet_key = ENV["SPREADSHEET_KEY"]
    worksheet_title = "速度テスト"

    @spreadsheet = session.spreadsheet_by_key(spreadsheet_key)
    @worksheet = @spreadsheet.worksheet_by_title(worksheet_title)
  end

  def append_row(rows)
    puts "スプレッドシートへの書き込み開始"
    @worksheet.insert_rows(@worksheet.num_rows + 1, rows)
    @worksheet.save
    puts "スプレッドシートへの書き込みに成功しました!"
  end

  # スプシ初期化
  def clear_worksheet
    puts "スプシ初期化開始"

    if @worksheet.num_rows > 0
      @worksheet.delete_rows(1, @worksheet.num_rows)
    else
      puts "スプシにデータがありません"
    end

    @worksheet.save
    puts "スプシ初期化完了"
  end
end