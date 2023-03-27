class AlbumRepository
    def all
      sql = 'SELECT * FROM albums;'
      results = DatabaseConnection.exec_params(sql, [])

      albums = []

      results.each { |record|
        album = Album.new
        album.id = record['id']
        album.title = record['title']
        album.release_year = record['release_year']
        album.artist_id = record['artist_id']

        albums << album
      }

      return albums
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      sql = "SELECT * FROM albums WHERE id = #{id};"
      results = DatabaseConnection.exec_params(sql, [])
      
      results.each { |record|
        album = Album.new
        album.id = record['id']
        album.title = record['title']
        album.release_year = record['release_year']
        album.artist_id = record['artist_id']

        return album
      }
      # Executes the SQL query:
      # SELECT * FROM albums WHERE id = $1;
  
      # Returns a single Album object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    def create(album)
    # Executes the SQL query:
    # INSERT INTO albums (title, release_year, artist_id)
    # VALUES($album.title, $album.release_year, $album.artist_id);
      sql = "INSERT INTO albums (title, release_year, artist_id)
      VALUES('#{album.title}', #{album.release_year}, #{album.artist_id});"

      DatabaseConnection.exec_params(sql, [])      
    end
  
    def update(id, album)
    # Executes the SQL query:
    # UPDATE albums SET title=$album.title , release_year=$album.release_year, artist_id=$album.artist_id WHERE id = $id;
      sql = "UPDATE albums SET 
        title='#{album.title}', 
        release_year=#{album.release_year}, 
        artist_id=#{album.artist_id} 
        WHERE id = #{id};"

      DatabaseConnection.exec_params(sql, [])
    end
  
    def delete(id)
    # Executes the SQL query:
      sql = "DELETE FROM albums WHERE id = #{id};"
      DatabaseConnection.exec_params(sql, [])
    end
end