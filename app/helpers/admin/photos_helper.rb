module Admin::PhotosHelper

  def photo_form_url
    begin
      url = current_page?(edit_admin_photo_path) ? admin_photo_path : photo_path
      return url
    rescue => exception
      url = photos_path
    end
  end

end
