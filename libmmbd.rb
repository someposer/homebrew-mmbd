require "formula"

class DmgDownloadStrategy < NoUnzipCurlDownloadStrategy
	def stage
		mountpoint = "/Volumes/makemkv_v1.12.3"
		output = `yes | hdiutil attach -nobrowse #{cached_location}`
		FileUtils.cp "#{mountpoint}/MakeMKV.app/Contents/lib/libmmbd.dylib", "libmmbd.dylib"
		`hdiutil detach "#{mountpoint}"`
	end
end


class Libmmbd < Formula
	url "https://www.makemkv.com/download/makemkv_v1.12.3_osx.dmg", :using => DmgDownloadStrategy
	homepage "http://www.makemkv.com/download/"
	version "1.12.3"
	sha256 "682009477252bda4264f1216cf8d109e8abf1493a25431579c439fcc180ca3ae"

	conflicts_with "libaacs", :because => "This formula implements libaacs as well as libbdplus"

	def install
		ln_s "libmmbd.dylib", "libaacs.dylib"
		ln_s "libmmbd.dylib", "libbdplus.dylib"
		lib.install Dir["*.dylib"]
	end
end
