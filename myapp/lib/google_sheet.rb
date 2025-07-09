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

  # スプシ書込み
  def append_row(rows)
    puts "スプシ書込中..."
    @worksheet.insert_rows(@worksheet.num_rows + 1, rows)
    @worksheet.save
    puts "スプシ書込完了"
  end

  # スプシ初期化
  def clear_worksheet
    return puts "スプシは既に空です" if @worksheet.num_rows == 0

    puts "スプシ初期化中..."
    @worksheet.delete_rows(1, @worksheet.num_rows)
    @worksheet.save
    puts "スプシ初期化完了"
  end
end