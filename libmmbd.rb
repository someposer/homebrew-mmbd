require "formula"

class DmgDownloadStrategy < NoUnzipCurlDownloadStrategy
	def stage
		output = `yes | hdiutil attach #{tarball_path}`
		lines = output.split(/\n/)
		mountpoint = lines.last.split.last
		FileUtils.cp "#{mountpoint}/MakeMKV.app/Contents/lib/libmmbd.dylib", "libmmbd.dylib"
		`hdiutil detach #{mountpoint}`
	end
end


class Libmmbd < Formula
	url "http://www.makemkv.com/download/makemkv_v1.8.11_osx.dmg", :using => DmgDownloadStrategy
	homepage "http://www.makemkv.com/download/"
	version "1.8.11"
	sha1 "0dfb5b5987af92ffff74733b0425fc14aa3df56e"

	def install
		ln_s "libmmbd.dylib", "libaacs.dylib"
		ln_s "libmmbd.dylib", "libbdplus.dylib"
		lib.install Dir["*.dylib"]
	end
end

