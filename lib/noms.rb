module Noms
  class Database
    attr_reader :name, :directory, :datastore

    attr_accessor :directory

    def db
      File.join(directory, name)
    end

    def ds
      db "::" + datastore
    end

    def initialize(name, args = {})
      @name = name
      args[:directory] ||= "."
      @directory = args[:directory]

      if @directory != "."
        unless FileTest.exist?(@directory)
          Dir.mkdir(@directory)
        end
      end

      args[:datastore] ||= "master"
      @datastore = args[:datastore]
    end

    def run(*cmd)
      p cmd
      system("noms", *cmd)
    end
  end
end

# noms blob put <file> <db>

# noms struct new --name Song Album 'G-Sides' Genre 'Electrronica/...' Duration 210 Title '19-2000' Blob @<ds>.value
# noms struct new --name Song ~/mydb Album 'G-Sides' Genre 'Electronica/Dance' Duration 210 Title '19-2000 (Soulchild Remix)' Blob @mp3.value
#
# nomw show <>
#
# noms struct set <mydb> <hash> Blob @ds.value
#
# noms set new ~/mydb @#ibikfkg09vps4pk101cg80suj5bg037p
#
# noms commit '#iljggv6mt55tbl9qt6canr66q17m5gh0' ~/mydb::my-mp3s
# New head #478didbggbpn5gnnscpp1prldqpck3m7
