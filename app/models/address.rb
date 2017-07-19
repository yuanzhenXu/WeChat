class Address < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  scope :not_deleted, -> {where("address.deleted_at IS NULL")}

  def display
    [province, city, street].compact.join('')
  end

  def fix_china_city
    self.province_code = '' if self.province_code == '-1'
    self.city_code= '' if self.city_code == '-1'
    self.district_code = '' if self.district_code == '-1'
    return true
  end

  def generate_province
    if province_code.present?
      self.province = ChinaCity.get(province_code)
    else
      self.province = ''
    end
  end

  def generate_city
    begin
      if city_code.present?
        self.city = ChinaCity.get(city_code)
      else
        self.city = ''
      end
    rescue
      self.city = ''
    end
    return true
  end

  def generate_district
    begin
      if district_code.present?
        self.district = ChinaCity.get(district_code)
      else
        self.district = ''
      end
    rescue
      self.district = ''
    end
    return true
  end

  def update_user_default_position
    if is_default
      user.addresses.unscoped.where('is_default =? and id <> ?', true, self.id).update_all('is_default = false')
    end
  end

end
