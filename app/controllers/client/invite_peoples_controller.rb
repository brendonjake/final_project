class Client::InvitePeoplesController < ApplicationController

  def index
    require "rqrcode"
    @promoter_link = "client.com:3000/users/sign_up?promoter=#{current_client_user.email}"
    qrcode = RQRCode::QRCode.new(@promoter_link)

    @png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 300
    )
  end
end