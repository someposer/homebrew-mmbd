require "formula"

class DmgDownloadStrategy < NoUnzipCurlDownloadStrategy
	def stage
		mountpoint = "/Volumes/libmmbd"
		output = `yes | hdiutil attach -nobrowse #{tarball_path} -mountpoint #{mountpoint}`
		FileUtils.cp "#{mountpoint}/MakeMKV.app/Contents/lib/libmmbd.dylib", "libmmbd.dylib"
		`hdiutil detach "#{mountpoint}"`
	end
end


class Libmmbd < Formula
	url "http://www.makemkv.com/download/makemkv_v1.8.11_osx.dmg", :using => DmgDownloadStrategy
	homepage "http://www.makemkv.com/download/"
	version "1.8.11"
	sha1 "0dfb5b5987af92ffff74733b0425fc14aa3df56e"

	conflicts_with "libaacs", :because => "This formula implements libaacs as well as libbdplus"

	def install
		ln_s "libmmbd.dylib", "libaacs.dylib"
		ln_s "libmmbd.dylib", "libbdplus.dylib"
		lib.install Dir["*.dylib"]
	end
end

