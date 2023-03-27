require 'album_repository'
require 'album'

def reset_albums_table
    seed_sql = File.read('spec/seeds.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library' })
    connection.exec(seed_sql)
end
  
describe AlbumRepository do
  before(:each) do 
    reset_albums_table
  end

  it "gets all albums" do
    repo = AlbumRepository.new
    
    albums = repo.all

    expect(albums.length).to eq 2

    expect(albums[0].id).to eq '1'
    expect(albums[0].title).to eq 'Surfer Roser'
    expect(albums[0].release_year).to eq '1988' 
    expect(albums[0].artist_id).to eq '1'

    expect(albums[1].id).to eq '2'
    expect(albums[1].title).to eq 'Waterloo'
    expect(albums[1].release_year).to eq '1972' 
    expect(albums[1].artist_id).to eq '2'
  end

  it "Gets a single album" do
    repo = AlbumRepository.new

    album = repo.find(1)

    expect(album.id).to eq '1'
    expect(album.title).to eq 'Surfer Roser'
    expect(album.release_year).to eq '1988'
    expect(album.artist_id).to eq "1"
  end

  it "updates an album" do
    repo = AlbumRepository.new

    album = Album.new
    album.title = '22 Make'
    album.release_year = '2022'
    album.artist_id = '3'

    repo.update(2, album)
    
    updated_album = repo.find(2)
    
    expect(updated_album.id).to eq "2"
    expect(updated_album.title).to eq "22 Make"
    expect(updated_album.release_year).to eq "2022" 
    expect(updated_album.artist_id).to eq "3"
  end

  it "creates an album" do 
    repo = AlbumRepository.new

    album = Album.new
    album.title = '22 Make'
    album.release_year = '2022'
    album.artist_id = '3'

    repo.create(album)
    
    updated_album = repo.find(3)
    
    expect(updated_album.id).to eq "3"
    expect(updated_album.title).to eq "22 Make"
    expect(updated_album.release_year).to eq "2022" 
    expect(updated_album.artist_id).to eq "3"

  end

  it "deletes an album" do
    repo = AlbumRepository.new

    repo.delete(2)

    albums = repo.all

    expect(albums.length).to eq 1
  end
end
