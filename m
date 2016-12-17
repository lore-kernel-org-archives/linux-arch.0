From: Adam Borowski <kilobyte@angband.pl>
Subject: Re: [GIT PULL] kbuild changes for v4.9-rc1
Date: Sat, 17 Dec 2016 10:33:57 +0100
Message-ID: <20161217093357.GA10602@angband.pl>
References: <20161017065131.GA27863@angband.pl>
 <20161017175951.31d8f4b7@roar.ozlabs.ibm.com>
 <20161017100130.GA16013@angband.pl>
 <7212667f-f508-2b41-a380-8f736814d8cc@suse.cz>
 <CA+55aFxjJbAXRq2HSxhfn2gWsGiLPTcqoRrrDLJrLd2vFLu9YQ@mail.gmail.com>
 <5ee08a93-6b17-d1c2-af1c-ab9aa218903c@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5ee08a93-6b17-d1c2-af1c-ab9aa218903c@suse.cz>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Omar Sandoval <osandov@osandov.com>, Michal Marek <mmarek@suse.com>, Alexey Dobriyan <adobriyan@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Al Viro <viro@zeniv.linux.org.uk>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Dec 17, 2016 at 09:57:47AM +0100, Jiri Slaby wrote:
> On 12/16/2016, 08:57 PM, Linus Torvalds wrote:
> > On Fri, Dec 16, 2016 at 11:55 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> >>
> >> what happened to this? I had to apply this to fix 4.9-pae kernel here.
> > 
> > Did you actually have to do that?
> 
> Yes, disk drivers won't load:
> [    2.141973] virtio_pci: disagrees about version of symbol mcount
> [    2.144415] virtio_pci: Unknown symbol mcount (err -22)
> and whole machine gets stuck with systemd waiting for /dev/sd*.
> 
> > Because a missing CRC shouldn't be fatal in 4.9.

Most of us get just a scary-looking warning, but whatever the problem is for
you, it's good to hear this patch works around it.

Whatever the long-term solution will be, for 4.10 an updated[1] version of
this fix is on kbuild/kbuild (and kbuild/for-next).  I guess we'll bother
stable@ once it is merged.

Note that it handles only x86, there's a bunch of other architectures
affected, alpha m68k s390 sparc ia64 might still need fixing.


Meow!

[1]. Turns out there was a missing symbol on 486; people build-test those
but don't try to actually boot, and even when they do, they don't read
warnings.
-- 
Autotools hint: to do a zx-spectrum build on a pdp11 host, type:
  ./configure --host=zx-spectrum --build=pdp11
