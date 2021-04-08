class Pokemon

    attr_accessor :id, :name, :type, :db

    def initialize(id:nil, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        new_pokemon = Pokemon.new(name:name, type:type, db:db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
        new_pokemon.id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
        new_pokemon
    end
    
    def self.find(id, db)
        sql = <<-SQL
            SELECT * FROM pokemon
            WHERE id = ?
        SQL

        poke_array = db.execute(sql, id)

        Pokemon.new(id:poke_array[0][0], name:poke_array[0][1], type:poke_array[0][2], db:poke_array[0][3])
    end

end
