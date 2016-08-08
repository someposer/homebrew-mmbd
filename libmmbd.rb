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
	url "http://www.makemkv.com/download/makemkv_v1.10.0_osx.dmg", :using => DmgDownloadStrategy
	homepage "http://www.makemkv.com/download/"
	version "1.10.0"
	sha256 "fc0f403c24b687d741780578be50832e14b199ba5ae9119020ec997804e65dd2"

	conflicts_with "libaacs", :because => "This formula implements libaacs as well as libbdplus"

	def install
		ln_s "libmmbd.dylib", "libaacs.dylib"
		ln_s "libmmbd.dylib", "libbdplus.dylib"
		lib.install Dir["*.dylib"]
	end
end

