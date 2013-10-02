module Database
require 'mysql'

# Connection information
# Change this out to an MD5 Hash at some point
  def self.connect
    begin
    @con=Mysql.new 'localhost','StudioGame','SandyG67','StudioGame'

    rescue Mysql::Error => e
    puts e.errno
    puts e.error
    end
  end

# Create database table
  def self.create
    begin
      connect

      @con.query("CREATE TABLE IF NOT EXISTS Players(id INT PRIMARY KEY AUTO_INCREMENT, \
            playername VARCHAR(25), \
            playerhealth INT(7))")

      @con.query("CREATE TABLE IF NOT EXISTS Treasures(id INT PRIMARY KEY AUTO_INCREMENT, \
            treasure VARCHAR(25), treasure_points INT(7))")

      @con.query("CREATE TABLE IF NOT EXISTS Player_Treasures (player_id INT, treasure_id INT, \
            PRIMARY KEY (player_id, treasure_id))")

    rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      @con.close if @con
    end
  end

# Add a player to the players table
  def self.add_player(player)
    begin
      connect
      pst = @con.prepare "INSERT INTO Players(playername, playerhealth) VALUES(?,?)"
      pst.execute player.pname, player.phealth
      system ('clear')
      puts "Player #{player.pname} with #{player.phealth} added to the database"
      print 'Press any key to continue...'
      gets
    rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      @con.close if @con
    end
  end

# Add a treasure to the Treasures table
  def self.add_treasure(treasure)
    begin
      connect
      pst = @con.prepare "INSERT INTO Treasures(treasure, treasure_points) VALUES(?,?)"
      pst.execute treasure.name, treasure.points
      system ('clear')
      puts "Treasure #{treasure.name} with #{treasure.points} added to the database"
      print 'Press any key to continue...'
      gets
    rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      @con.close if @con
    end
  end

  def self.get_players
    begin
      connect
      pst = @con.prepare "SELECT  playername, playerhealth FROM Players"
      pst.execute

    rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      @con.close if @con
    end
  end

 def self.get_treasures
    begin
      connect
      pst = @con.prepare "SELECT  treasure, treasure_points FROM Treasures"
      pst.execute

    rescue Mysql::Error => e
      puts e.errno
      puts e.error

    ensure
      @con.close if @con
    end
  end

  if __FILE__ == $0
    p=get_players
    t=get_treasures
    puts p.class
    puts t.class


    p.each { |p1| puts "#{ p1[0] } #{ p1[1] }" }
    t.each { |t1| puts "#{ t1[0] } #{ t1[1] }" }

  end
end
