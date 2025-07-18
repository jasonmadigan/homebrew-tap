# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class PodmanMacNetConnect < Formula
  desc "Connect directly to Podman for macOS containers via IP address 🐳 💻"
  homepage "https://github.com/jasonmadigan/podman-mac-net-connect"
  version "0.1.2"
  url "https://github.com/jasonmadigan/podman-mac-net-connect/archive/refs/tags/v#{version}.tar.gz"
  sha256 "794914d6a126745afafa5ef3847a99b0420cccd97953cbab77426636c90f0ea5"
  license "MIT"

  depends_on "go" => :build
  depends_on "gpgme" => "1.23.2+"
  depends_on "pkg-config" => "0.29.2"

  def install
    if ENV["HOMEBREW_GOPROXY"]
      ENV["GOPROXY"] = ENV["HOMEBREW_GOPROXY"]
    end

    system "make", "VERSION=#{version}", "build-go"
    
    bin.install "podman-mac-net-connect"
  end

  service do
    keep_alive true
    run opt_bin/"podman-mac-net-connect"
    log_path var/"log/podman-mac-net-connect/std_out.log"
    error_log_path var/"log/podman-mac-net-connect/std_error.log"
    environment_variables PATH: "/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin",
                          HOME: ENV["HOME"]
  end  

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test podman-mac-net-connect`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
