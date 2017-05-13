From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 07:57:45 +0100
Message-ID: <20170513065745.GV390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:59118 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbdEMG5r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 02:57:47 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Fri, May 12, 2017 at 06:00:44PM -0700, Linus Torvalds wrote:
> So I should have asked earlier, but I was feeling rather busy during
> the early merge window..

> So I'm actually more interested to hear if you have any pending work
> on cleaning up the __get/put_user() mess we have. Is that on your
> radar at all?

Yes, it is.

> In particular, right now, both __get_user() and __put_user() are nasty
> and broken interfaces.
>
> It *used* to be that they were designed to just generate a single
> instruction. That's not what they currently do at all, due to the
> whole SMAP/PAN on x86 and arm.
> 
> For example, on x86, right now a single __put_user() call ends up
> generating something like

[snip]
 
> But even that small thing is rather debatable from a performance
> angle: the actual cost of __put_user() these days is not the function
> call, but the clac/stac (on modern x86) and the PAN bit games (on
> arm).
> 
> So I'm actually inclined to just say "We should make
> __get_user/__put_user() just be aliases for the normal
> get_user/put_user() model".

> which is more boilerplate, but ends up generating much better code.
> And for "unsafe_put_user()" in particular, we actually could teach gcc
> to use "asm goto" to really improve code generation. I have patches
> for that if you want to look.
> 
> I'm attaching an example patch for "filldir()" that does that modern
> thing. It almost had the right form as-is anyway, and under some loads
> (eg "find") filldir actually shows up in profiles too.\

> But the *first* thing I'd like to do would be to just get rid of
> __get_user/__put_user as a thing. It really does generate nasty code,
> and we might as well just make it do that function call.
> 
> Because what we do now isn't right. If we care about performance, the
> "__xyz_user" versions are wrong (use unsafe_xyz_user() instead). And
> if you don't care about performance, you should use the regular
> xyz_user() functions that do an ok job by just calling the right-sized
> helper function instead of inlining the crud.
> 
> Hmm?

First, some stats: there's a thousand-odd callers of __get_user().  Out of
those, about 70% are in arch/, mostly in sigframe-related code.  Take
a look at the output of
git grep -n -w __get_user|grep -v '^arch' | sed -e 's/:.*//'|uniq -c|sort -nr
     55 drivers/gpu/drm/drm_ioc32.c
     43 drivers/staging/comedi/comedi_compat32.c
     35 kernel/compat.c
     27 net/compat.c
     27 block/compat_ioctl.c
     15 drivers/usb/core/devio.c
     13 drivers/char/ipmi/ipmi_devintf.c
     11 kernel/signal.c
     10 fs/fcntl.c
      8 ipc/compat.c
      8 drivers/video/fbdev/sbuslib.c
      7 net/socket.c
      7 drivers/gpu/drm/mga/mga_ioc32.c
      6 fs/select.c
      6 drivers/tty/vt/vt_ioctl.c
      5 drivers/tty/vt/selection.c
      5 drivers/spi/spidev.c
      5 drivers/pci/proc.c
      4 kernel/ptrace.c
      4 ipc/compat_mq.c
      4 drivers/tty/vt/consolemap.c
      3 sound/oss/sys_timer.c
      3 drivers/media/usb/uvc/uvc_v4l2.c
      3 drivers/macintosh/ans-lcd.c
and then we have a smallish bunch of files with one or two callers.  For
__put_user() we have ~1800 callers total, ~1100 of them in arch/* and
the rest goes like this:
     73 drivers/gpu/drm/drm_ioc32.c
     66 ipc/compat.c
     58 drivers/gpu/drm/radeon/radeon_ioc32.c
     55 block/compat_ioctl.c
     52 kernel/compat.c
     49 kernel/signal.c
     43 drivers/staging/comedi/comedi_compat32.c
     31 drivers/gpu/drm/r128/r128_ioc32.c
     30 drivers/gpu/drm/mga/mga_ioc32.c
     27 fs/signalfd.c
     25 fs/readdir.c
     24 fs/statfs.c
     19 kernel/sys.c
     17 net/compat.c
     11 drivers/scsi/sg.c
     10 fs/fcntl.c
      8 sound/core/pcm_native.c
      8 fs/binfmt_flat.c
      7 fs/binfmt_elf_fdpic.c
      6 net/socket.c
      6 drivers/char/ipmi/ipmi_devintf.c
      5 sound/oss/sys_timer.c
      5 fs/binfmt_elf.c
      5 drivers/video/fbdev/sbuslib.c
      5 drivers/tty/vt/consolemap.c
      5 drivers/spi/spidev.c
      5 drivers/pci/proc.c
      4 kernel/ptrace.c
      4 ipc/compat_mq.c
      3 fs/select.c
      3 drivers/tty/vt/vt.c
      ...

IOW, we have
	* most of users in arch/* (heavily dominated by signal-related code,
both loads and stores).  Those need careful massage; maybe unsafe-based
solution, maybe something else, but it's obviously per-architecture work
and these paths are sensitive.
	* few places outside of arch/* where these are abused; absolute
majority are in ioctl compat code and they are _bad_.  Bad on x86, bad on
s390, etc.  I'm not sure if switch to unsafe is the right solution for
those, actually - depends on how we end up dealing with compat ioctls of
that sort.  Might be better to do bulk copy to/from userland, combined with
conversion from 32bit to native kernel-side and passing pointers to kernel
objects to functions doing actual work.  Really depends upon the details.
	* some places in fairly common codepaths where __get_user() and
__put_user() are being played with.  And I certainly agree that they are
not good.

But IMO the first step is not to convert __get_user()/__put_user() to
aliases of get_user()/put_user() - it's to get rid of their infestations
outside of arch/*.  They are concentrated in relatively few places, so
we can deal with those individually and then just fucking ban their use
outside of arch/*.  That's easy enough to watch for - simple git grep will do,
so anything creeping back will be immediately spotted.  In -next, with
subsequent explanation of the reasons Not To Do That Or Else(tm) to the
people responsible.

As for fs/readdir.c...  4 back-to-back stores like
        if (__put_user(ino, &dirent->d_ino))
                goto efault;
        if (__put_user(0, &dirent->d_off))
                goto efault;
        if (__put_user(reclen, &dirent->d_reclen))
                goto efault;
        if (__put_user(d_type, &dirent->d_type))
                goto efault;
might be asking for copy_to_user().  Maybe that one is too small for that
to be a win (on s390 it almost certainly would be a win, judging by what
Martin and Heiko are saying); fs/statfs.c ones almost certainly are better
off with 'convert, then copy_to_user()' approach.

Another couple of places worth looking into are copy_siginfo_to_user() and
signalfd_copyinfo().  Maybe unsafe is the best approach there as well,
maybe not, but it's in the 'large enough for copy_to_user() be interesting,
not too large for auto variable' range.

I certainly want that shit gone from the common paths, no arguments here,
but I want to avoid having to crawl through every architecture's sigframe
handling first.  Fortunately, we have that crap outside of arch/* concentrated
in a few places and they are far enough from each other to be dealt with
independently.  There are interesting interplays with set_fs() stuff, BTW...

There will be more than enough crap that _will_ require crawls through
arch/* ;-/  I'm plotting that pile right now (basically, what pieces should
go into never-rebased stem, so that per-architecture branches had what they
need).  get_user()/put_user() are part of it, it's just that I don't want
to bring arch/*/kernel/signal*.c into the mix ;-/

Re asm-goto - which architectures would be able to use that?  IOW, which
gcc versions are stable enough in that area?  I'd obviously like to see
your patches...
