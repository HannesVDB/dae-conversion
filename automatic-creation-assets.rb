#!/usr/bin/ruby

def which(cmd)
    exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
    ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
      exts.each { |ext|
        exe = File.join(path, "#{cmd}#{ext}")
        return exe if File.executable?(exe) && !File.directory?(exe)
      }
    end
    return nil
end

def createFolder(name)
    $file_name = name
    puts "⚡️ - Creating new folder if not exists: #$file_name"
    if File.exists?("#$file_name.scnassets")
        puts "👍 - Folder already exists"
    else
        Dir.mkdir("#$file_name.scnassets")
        puts "🗂 - Folder created"
    end
end

def convertDae(name)
    $file_name = name
    if which("xcrun") == nil
        puts "⚠️ - xcrun not installed please install it"
    else
        puts "✅ - xcrun installed"
        system("xcrun scntool --convert #$dae_directory/#$file_name.dae --format scn --output #$scene_directory/#$file_name.scnassets/#$file_name.scn --verbose")
    end
end

$scene_directory = "SCENE-FILES"
$dae_directory = "DAE-FILES"

puts "🏁 Start script ---"

Dir.foreach($dae_directory) do |dae|
    next if dae == '.' or dae == '..'
    $dae_name = File.basename(dae, ".dae")
    puts "🤖 - Working on #$dae_name"
    createFolder("#$scene_directory/#$dae_name")
    puts "👨‍💻 - Starting xcrun scntool"
    convertDae($dae_name)
end

puts "🏁 End script ---"
