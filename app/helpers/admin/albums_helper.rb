module Admin::AlbumsHelper

  def album_form_url(mode)
    begin
      url = current_page?(edit_admin_album_path) ? admin_album_path : album_path
      return url
    rescue => exception
      url = albums_path
    end
  end

end
