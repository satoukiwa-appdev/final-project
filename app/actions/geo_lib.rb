class Geo_Lib
    include Math

    
    #https://qiita.com/4geru/items/27785e9066c4e22eeaa3
    #calculates distance between 2 coordinates (in km)
    def self.geo_distance(pos1, pos2)
        y1, x1, y2, x2 = [*pos1, *pos2].map{ |v| v * PI / 180 }
        earth_r = 6378.14 # km
        cos_theta = sin(y1) * sin(y2) + cos(y1) * cos(y2) * cos(x2 - x1)
        earth_r * acos(cos_theta)
    end 
    
    
    # https://qiita.com/niwasawa/items/5128101ef93a56e8a6af
    # 球面三角法により、大円距離(メートル)を求める
    def self.distance(lat1, lng1, lat2, lng2)
    
      # 緯度経度をラジアンに変換
      rlat1 = lat1 * Math::PI / 180
      rlng1 = lng1 * Math::PI / 180
      rlat2 = lat2 * Math::PI / 180
      rlng2 = lng2 * Math::PI / 180
    
      # 2点の中心角(ラジアン)を求める
      a =
        Math::sin(rlat1) * Math::sin(rlat2) +
        Math::cos(rlat1) * Math::cos(rlat2) *
        Math::cos(rlng1 - rlng2)
      rr = Math::acos(a)
    
      earth_radius = 6378140 # 地球赤道半径(メートル)
      earth_radius * rr
    end
    
    
    
end