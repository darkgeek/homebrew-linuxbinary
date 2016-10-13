class Teamviewer < Formula
    desc "Remote support, remote access, and online meeting software that the world relies on."
    homepage "http://www.teamviewer.com/"
    version :latest
    sha256 :no_check

    url "http://download.teamviewer.com/download/teamviewer_i386.tar.xz"

    bottle :unneeded

    def install
        libexec.install Dir["*"]
        (libexec/"teamviewer_brew_exec").write <<-EOS.undent
            #!/usr/bin/env bash
            cd $(brew --prefix teamviewer)/libexec
            ./teamviewer
        EOS
        FileUtils.chmod(0755, "#{libexec}/teamviewer_brew_exec")
        bin.install_symlink({"#{libexec}/teamviewer_brew_exec" => "teamviewer"})
    end

    def caveats; <<-EOS.undent
        Teamviewer is a 32-bit software, so if you want to use it 
        in a 64-bit system, you have to install 32-bit shared libraries
        like dbus based on the linux distro you use otherwise you may eccounter errors like:
            "Cannot open shared object file: No such file or directory"
        EOS
    end
end
