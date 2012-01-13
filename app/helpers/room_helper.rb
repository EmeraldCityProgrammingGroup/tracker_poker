module RoomHelper
  def get_qr_url(id)
    "https://chart.googleapis.com/chart?cht=qr&chs=300x300&chl=#{id}"
  end
end
