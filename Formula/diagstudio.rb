
class Diagstudio < Formula
  desc "Camera and audio diagnostics for macOS and Linux"
  homepage "https://github.com/DiagStudio/diagstudio"
  url "https://github.com/DiagStudio/diagstudio/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "f35a709277a372e840e4ac5ef3de76c3b561443708d40158f9f19285b2b47d8a"
  license "MIT"

  on_linux do
    depends_on "swift" => :build
  end

  def install
    system "curl", "-fsSL", "-o", "#{buildpath}/smoke-test.sh", "https://raw.githubusercontent.com/DiagStudio/diagstudio/main/scripts/smoke-test.sh"
    system "bash", "scripts/build.sh"
    bin.install ".build/diagstudio"
  end
  
  def caveats
    if OS.linux?
      <<~EOS
        Linux camera and audio diagnostics also require:
          v4l2-ctl (from v4l-utils)
          arecord and aplay (from alsa-utils)

        On Ubuntu/Debian, install them using:
          sudo apt-get install v4l-utils alsa-utils

        Use 'diagstudio audio list' to discover ALSA microphones.
      EOS
    end
  end

  test do
    assert_match "DiagStudio 0.2.0",
      shell_output("#{bin}/diagstudio --version")
  end
end
