module Database
require 'win32ole'

# Connection information
# Change this out to an MD5 Hash at some point
  def self.connect
    @con=WIN32OLE.new ('ADODB.Conneciton')
    @con.Open ('Provider = Microsoft.ACE.OlEDB.12.0; C:\SampleApp\StudioGame.accdb')
  end

# Create database table
  def self.create
      connect
      @con.query("CREATE TABLE IF NOT EXISTS Players(id INT PRIMARY KEY AUTO_INCREMENT, \
            playername VARCHAR(25), \
            playerhealth INT(7))")

      @con.query("CREATE TABLE IF NOT EXISTS Treasures(id INT PRIMARY KEY AUTO_INCREMENT, \
            treasure VARCHAR(25), treasure_points INT(7))")

      @con.query("CREATE TABLE IF NOT EXISTS Player_Treasures (player_id INT, treasure_id INT, \
            PRIMARY KEY (player_id, treasure_id))")
  end

# Add a player to the players table
  def self.add_player(player)
      connect
      rs=WIN32OLE.new('ADODB.Recordset')
      rs.Open("INSERT INTO Players VALUES(player.pname, player.phealth);", @con)
      # puts "Player #{player.pname} with #{player.phealth} added to the database"
      # print 'Press any key to continue...'
      # gets
  end

# Add a treasure to the Treasures table
  def self.add_treasure(treasure)
      connect
      @con.openrecordset ("INSERT INTO Treasures VALUES(treasure.name, treasure.points);")
      system ('cls')
      puts "Treasure #{treasure.name} with #{treasure.points} added to the database"
      print 'Press any key to continue...'
      gets
  end

  def self.get_players
      connect
      rs = @con.openrecordset "SELECT  playername, playerhealth FROM Players;"
  end

  def self.get_treasures
      connect
      rs = @con.openrecordset "SELECT  treasure, treasure_points FROM Treasures;"
  end
end
