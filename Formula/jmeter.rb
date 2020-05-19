class Jmeter < Formula
  desc "Load testing and performance measurement application"
  homepage "https://jmeter.apache.org/"
  url "https://www.apache.org/dyn/closer.lua?path=jmeter/binaries/apache-jmeter-5.3.tgz"
  mirror "https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-5.3.tgz"
  sha256 "d0611b46268c4e24220fed56e76d770077713ff863665c271ed6521046f2f0d0"

  bottle do
    cellar :any_skip_relocation
    sha256 "506e7058e3fe83d5357ba4beb860205d253d9f9a548d6ffebc4d2d08213b0117" => :catalina
    sha256 "506e7058e3fe83d5357ba4beb860205d253d9f9a548d6ffebc4d2d08213b0117" => :mojave
    sha256 "506e7058e3fe83d5357ba4beb860205d253d9f9a548d6ffebc4d2d08213b0117" => :high_sierra
  end

  resource "jmeter-plugins-manager" do
    url "https://search.maven.org/remotecontent?filepath=kg/apc/jmeter-plugins-manager/1.3/jmeter-plugins-manager-1.3.jar"
    sha256 "482b8a9cd82a69ef1b633fc4235bfa9bee96894f663e5085df7061410d6ab99a"
  end

  def install
    # Remove windows files
    rm_f Dir["bin/*.bat"]
    prefix.install_metafiles
    libexec.install Dir["*"]
    bin.write_exec_script libexec/"bin/jmeter"

    resource("jmeter-plugins-manager").stage do
      (libexec/"lib/ext").install Dir["*"]
    end
  end

  test do
    system "#{bin}/jmeter", "--version"
  end
end
