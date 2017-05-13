From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 17:46:14 +0100
Message-ID: <20170513164614.GW390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <20170513120527.sdmkwveoo2mq32hf@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:39728 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754235AbdEMQqS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 12:46:18 -0400
Content-Disposition: inline
In-Reply-To: <20170513120527.sdmkwveoo2mq32hf@angband.pl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adam Borowski <kilobyte@angband.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 02:05:27PM +0200, Adam Borowski wrote:

> As someone from the peanuts gallery, I took a look for __put_user() in my
> usual haunt, drivers/tty/vt/
> 
> * use 1: con_[gs]et_trans_*():
>   Copies a linear array of 256 bytes/shorts, one by one.
>   The obvious patch has 9 insertions(+), 22 deletions(-).
> 
> * use 2: con_[gs]et_unimap():
>   Ditto, up to 65535*2 shorts, also in a nice linear array.
> 
> * use 3: tioclinux():
>   Does a __put into a place that was checked only for read.  This got me
>   frightened as it initially looked like something that can allow an user to
>   write where they shouldn't.  Fortunately, it turns out the first argument
>   to access_ok() is ignored on every single architecture -- why does it even
>   exist then?  I imagined it's there for some odd arch that allows writes
>   when in privileged mode, but unlike what the docs say, VERIFY_WRITE is
>   exactly same as VERIFY_READ.

It's a remnant of old kludge that never properly worked in the first place.
access_ok() should have been called userland_range() - that's all it
checks and that's all it *can* check.

As it is, each of those __get_user() can bloody well yield -EFAULT.  Despite
having "passed" access_ok().  Again, the only thing access_ok() checks is
that (on architecture with shared address space for userland and kernel)
the addresses given are on the userland side.  That's _it_ - they can
be unmapped, mmapped to broken floppy, whatever; you'll find out when
you try to actually copy bytes from from it.

What the kludge used to attempt was "let's check that we are not trying
to copy into read-only mmapped area - 80386 MMU is fucked in head and won't
fault on such stores in ring 0".  It had always been racy.  Look:
thread A: going to copy something to user-supplied address.  Do access_ok().
thread A: looks like it's mapped writable, let's go ahead and copy
thread A: do something blocking before actually doing __put_user() or
__copy_to_user() or whatever it's going to be.
thread B: munmap(), mmap() something read-only here.
thread A: get to actual __put_user()/__copy_to_user().
80386: hey, it's ring 0, no need to look at the write protect bit in page
tables.  What can go wrong, anyway?

You can't move any non-static checks to access_ok().  On any architecture.
Anything that could change between access_ok() and actual copying can't
be checked in access_ok().  As it is, access_ok() has actively misleading
calling conventions:
	* the name implies that having passed access_ok() you don't have
to worry about EFAULT
	* 'direction' argument of that thing reinforces that impression
*and* has to be produced by the caller.  Most simply pass a constant,
which immediately gets dropped (as an aside, take a look at 4b4554f6d - it's
amusing), but in some cases it's calculated elsewhere and carefully passed
through several levels of call chain.  Only to be discarded by access_ok(),
of course...

> Ie, every use in this sample is wrong.  I suspect the rest of the kernel
> should be similar.

Looking through vt...

* con_set_trans_old(): copy_from_user() + loop for doing or with
  UNI_DIRECT_BASE.  Almost certainly will be faster that way - on *any*
  architecture.
* con_get_trans_old(): copy_to_user() would be an obvious optimization.
* con_set_trans_new(): copy_from_user().
* con_get_trans_new(): copy_to_user().
* con_set_unimap(): memdup_user() instead of the entire kmalloc_array +
loop copying the sucker member by member.  With ushort ct you don't need
overflow-related logics of kmalloc_array() anyway...
* con_get_unimap(): copy_to_user() + put_user() (for uct)
* set_selection(): just copy_from_user() into local struct tiocl_selection.
* tioclinux(): use put_user().  Yes, you will repeat the same check twice.
Once per ioctl(), that involves enough work to make that "recalculate
access_ok() once for no reason" non-issue on any architecture.
* vt_ioctl(): turn that ushort ll,cc,vlin,clin,vcol,ccol; into
  struct vt_consize size; or something like that and use copy_from_user()

And AFAICS you can lose each and every access_ok() call in there.
