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
	url "http://www.makemkv.com/download/makemkv_v1.10.2_osx.dmg", :using => DmgDownloadStrategy
	homepage "http://www.makemkv.com/download/"
	version "1.10.2"
	sha256 "cb2dd115242e2ab0c11aa1e167aa44337094410a621855326c90f6b5dd6f40c7"

	conflicts_with "libaacs", :because => "This formula implements libaacs as well as libbdplus"

	def install
		ln_s "libmmbd.dylib", "libaacs.dylib"
		ln_s "libmmbd.dylib", "libbdplus.dylib"
		lib.install Dir["*.dylib"]
	end
end

