From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Remove #ifdef CONFIG_64BIT from all asm-generic/fcntl.h
Date: Mon, 07 Sep 2015 15:59:15 +0200
Message-ID: <2644177.lVCYzIBfPW@wuerfel>
References: <55ed92a9.6589440a.ce436.0f80@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59782 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbIGN7W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2015 09:59:22 -0400
In-Reply-To: <55ed92a9.6589440a.ce436.0f80@mx.google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>, sw-dev@lists.riscv.org
Cc: linux-arch@vger.kernel.org

On Monday 07 September 2015 06:35:37 Palmer Dabbelt wrote:
> On Mon, 07 Sep 2015 06:16:37 PDT (-0700), arnd@arndb.de wrote:
> > On Tuesday 01 September 2015 17:10:10 Palmer Dabbelt wrote:
> >> From: Palmer Dabbelt <palmer.dabbelt@eecs.berkeley.edu>
> >>
> >> When working on the RISC-V port I noticed that F_SETLK64 was being
> >> defined on our 64-bit platform, despite our port being so new that
> >> we've only ever had the 64-bit file ops.  Since there's not compat
> >> layer for these, this causes fcntl to bail out.
> >>
> >> It turns out that one of the ways in with F_SETLK64 was being defined
> >> (there's some more in glibc, but that's a whole different story... :))
> >> is the result of CONFIG_64BIT showing up in this user-visible header.
> >> <asm-generic/bitsperlong.h> confirms this isn't sane, so I replaced it
> >> with a __BITS_PER_LONG check.
> >>
> >> I went ahead and grep'd for any more of these (with
> >> headers_install_all), and this was the only one I found.
> >>
> >> Signed-off-by: Palmer Dabbelt <palmer.dabbelt@eecs.berkeley.edu>
> >> Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
> >> Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
> >
> > Looks good to me. Are you planning to submit the RISC-V port upstream
> > any time soon? If so, just keep the patch in your tree and add my
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> The RISC-V stuff is still a few months off, that's why I submitted this
> upstream stand-alone.  The supervisor specification isn't 100% set in
> stone yet, and we're waiting on that before upstreaming anything
> significant.

Ok, I see.

[adding sw-dev@l.r.o]

While this is a separate topic, I'd suggest you already start posting
the patches for review anyway, for two reasons:

- Almost all of your code won't change any more, so by having it
  reviewed early, the review can be done by the time that the spec
  is ready and we can just merge it all. It's very rare that a new
  architecture gets merged within a single review cycle, so this
  buys you some more time.

- The people that do the review will also be the ones that are
  experienced on other architectures, so if there are some open
  questions for the architecture spec, we may be able to provide
  helpful suggestions. It's even possible that there is something
  that RISC-V currently does suboptimally and you only find out
  about it in the review.

In any case, when posting patches, just let us know when a patch
is in a preliminary state, or when you already have plans to change
a patch further.

> > However, I did see a lot of similar bugs now that you point me to it:
> >
> > $  grep -r \\\<CONFIG obj-tmp/usr/include/
> > obj-tmp/usr/include/asm-generic/fcntl.h:#ifndef CONFIG_64BIT
> > obj-tmp/usr/include/asm-generic/mman-common.h:#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
> > obj-tmp/usr/include/asm-generic/unistd.h:#ifdef CONFIG_MMU
> > obj-tmp/usr/include/asm-generic/unistd.h:#endif /* CONFIG_MMU */
> > obj-tmp/usr/include/linux/atmdev.h:#ifdef CONFIG_COMPAT
> > obj-tmp/usr/include/linux/elfcore.h:#ifdef CONFIG_BINFMT_ELF_FDPIC
> > obj-tmp/usr/include/linux/eventpoll.h:#ifdef CONFIG_PM_SLEEP
> > obj-tmp/usr/include/linux/fb.h:#ifdef CONFIG_FB_BACKLIGHT
> > obj-tmp/usr/include/linux/flat.h:#ifdef CONFIG_BINFMT_SHARED_FLAT
> > obj-tmp/usr/include/linux/hw_breakpoint.h:#ifdef CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
> > obj-tmp/usr/include/linux/pktcdvd.h:#if defined(CONFIG_CDROM_PKTCDVD_WCACHE)
> > obj-tmp/usr/include/linux/raw.h:#define MAX_RAW_MINORS CONFIG_MAX_RAW_DEVS
> > obj-tmp/usr/include/asm/ptrace.h:#ifdef CONFIG_CPU_ENDIAN_BE8
> >
> > These all have the same problem, and we should fix them, as well as
> > (probably) adding an automated check to scripts/headers_install.sh.
> 
> Well, I was going to go fix them all and ran a very similar grep, but
> I think I got a lot of false-positives.  If I understand correctly,
> it's allowed to have CONFIG_* when guarded by __KERNEL__ in
> user-visible headers?

That is right.

> Now that I've written that, I realize it'd be pretty easy to just use
> cpp to drop everything inside __KERNEL__ and then look for CONFIG_*.

The lines quoted above are from the output of 'make headers_install',
which already drops everything inside of __KERNEL__. A lot of them
probably just need to add that #ifdef, or move the portion of the
header file to the normal (non-uabi) file.

> If you want, I can try to do that, fix what triggers the check, and
> re-submit everything together?

That would be great, yes.

	Arnd
