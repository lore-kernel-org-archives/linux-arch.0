From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [PATCH] x86/kbuild: enable modversions for symbols exported from
 asm
Date: Tue, 29 Nov 2016 18:05:22 +0100
Message-ID: <20161129170522.GA3441@angband.pl>
References: <20161129131922.GA31466@angband.pl>
 <20161129135118.24696-1-kilobyte@angband.pl>
 <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <bounce-debian-kernel=glddk-debian-kernel=m.gmane.org@lists.debian.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyZiB4YkwvqzrXO=HD8bcnc2xHkAYrek2QHVnhVvAi3Fw@mail.gmail.com>
Resent-Message-ID: <nhdn0Aa-Uz.A.jRE.uVbPYB@bendel>
List-URL: <https://lists.debian.org/debian-kernel/>
List-Post: <mailto:debian-kernel@lists.debian.org>
List-Help: <mailto:debian-kernel-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-kernel-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-kernel-request@lists.debian.org?subject=unsubscribe>
List-Archive: https://lists.debian.org/msgid-search/20161129170522.GA3441@angband.pl
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Ben Hutchings <ben@decadent.org.uk>, Debian kernel maintainers <debian-kernel@lists.debian.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 29, 2016 at 07:27:12AM -0800, Linus Torvalds wrote:
> On Nov 29, 2016 5:51 AM, "Adam Borowski" <kilobyte@angband.pl> wrote:
> > >
> > >  (a) tested
> >
> > By many people.
> 
> No.
> 
> I've tested the build *without* this, and it works fine.

Michal mentioned "why", let's try "where".

I have no idea what setup is required to trigger the problem, but here's a
simple sufficient one:

Current Debian unstable, amd64.
git reset --hard v4.9-rc7
git revert cd3caefb
make defconfig
CONFIG_MODVERSIONS=y
(in my case) CONFIG_BTRFS_FS=y (so I can boot)
enable a module for testing, I used CONFIG_EXT4_FS=m
make bindeb-pkg
dpkg -i linux-image_XXXXX.deb

modprobe ext4
[   63.779490] jbd2: no symbol version for memcpy
[   63.779492] jbd2: Unknown symbol memcpy (err -22)
[   63.779550] jbd2: no symbol version for phys_base
[   63.779551] jbd2: Unknown symbol phys_base (err -22)
[   63.779561] jbd2: no symbol version for memset
[   63.779562] jbd2: Unknown symbol memset (err -22)

Not sure which piece of toolchain matters here, someone said binutils.
In that case, Fedora ships 2.26.1-1.fc25, they were frozen so couldn't
update.  Debian is at 2.27.51.20161127-1, Gentoo at 2.27, same for Arch,
OpenSUSE; Ubuntu at 2.27.51.20161124-1.

Thus, if it's indeed binutils, you'll see the breakage as soon as Fedora
recovers from the freeze.


Meow!
