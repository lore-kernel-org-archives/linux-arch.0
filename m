From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 22:08:16 +0100
Message-ID: <20170330210816.GV29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <20170330162241.GG7909@n2100.armlinux.org.uk>
 <20170330164342.GR29622@ZenIV.linux.org.uk>
 <CA+55aFzsGSKzbQjWAPxFvc=HeXyr6stk1KsB-1xGCKALgazYuQ@mail.gmail.com>
 <20170330184824.GS29622@ZenIV.linux.org.uk>
 <20170330185427.GT29622@ZenIV.linux.org.uk>
 <CA+55aFx2u6iUzJV1ZH4w_o6tTZesSGoOxMrOtJB8aXScou6zPg@mail.gmail.com>
 <20170330191009.GU29622@ZenIV.linux.org.uk>
 <CA+55aFwktbgtL_x4gKqcJU6=FrkokneLRQ30HtDhuR2WErG83w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:57154 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934217AbdC3VIp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 17:08:45 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFwktbgtL_x4gKqcJU6=FrkokneLRQ30HtDhuR2WErG83w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>

On Thu, Mar 30, 2017 at 12:19:35PM -0700, Linus Torvalds wrote:
> On Thu, Mar 30, 2017 at 12:10 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > That they very definitely should not.  And not because of access_ok() or
> > might_fault() - this is one place where zero-padding is absolutely wrong.
> > So unless you are going to take it out of copy_from_user() and pray
> > that random shit ioctls in random shit drivers check the return value
> > properly, copy_from_user() is no-go here.
> 
> Actually, that is a great example of why you should *not* use
> __copy_from_user().
> 
> If the reason is lack of zero-padding, that doesn't mean that suddenly
> we shouldn't check the range. And it doesn't mean that it shouldn't
> document why it does it.
> 
> So dammit, just add something like this to lib/iovec.c:
> 
>     static inline unsigned long copy_from_user_nozero(void *to, const
> void __user *from, size_t len)
>     {
>         if (!access_ok(from, len))
>             return len;
>         return __copy_from_user(to, from, len);
>     }
> 
> which now isn't insecure, and also magically documents *why* you don't
> just use the plain copy_from_user().

Maybe...  However, we *do* have places where it's done under kmap_atomic()
in there.  Let's leave that one until this round of uaccess consolidation is
finished, OK?  lib/iov_iter.c is special and isolated enough; we can figure
out what to do with those primitives later.

As far as I'm concerned, lib/*.c and mm/*.c are separate story; I would start
with getting rid of that stuff in random drivers.  Here's what we have at the
moment:

there are only 3 irregular callers of __copy_to_user_inatomic():

arch/mips/kernel/unaligned.c:1276:                      res = __copy_to_user_inatomic(addr, fpr, sizeof(*fpr));
drivers/gpu/drm/i915/i915_gem.c:913:            ret = __copy_to_user_inatomic(user_data, vaddr + offset, length);
drivers/gpu/drm/i915/i915_gem.c:983:    unwritten = __copy_to_user_inatomic(user_data, vaddr + offset, length);

There are 32 irregular callers of __copy_from_user_inatomic(), majority in
perf/oprofile-related code.  Leave those aside, only 8 are left:

arch/mips/kernel/unaligned.c:1242:                              res = __copy_from_user_inatomic(fpr, addr,
drivers/gpu/drm/i915/i915_gem.c:1324:           ret = __copy_from_user_inatomic(vaddr + offset, user_data, len);
drivers/gpu/drm/i915/i915_gem_execbuffer.c:669:         unwritten = __copy_from_user_inatomic(r, user_relocs, count*sizeo
f(r[0]));
drivers/gpu/drm/msm/msm_gem_submit.c:73:                return __copy_from_user_inatomic(to, from, n);
kernel/trace/trace.c:5780:      len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
kernel/trace/trace.c:5851:      len = __copy_from_user_inatomic(&entry->id, ubuf, cnt);
kernel/trace/trace_kprobe.c:216:                ret = __copy_from_user_inatomic(&c, (u8 *)addr + len, 1);
virt/kvm/kvm_main.c:1832:       r = __copy_from_user_inatomic(data, (void __user *)addr + offset, len);

Ones in perf and oprofile code really smell like a missing helper,
along the lines of probe_kernel_read(), but for userland pointers.
Incidentally, metag, mips, openrisc and xtensa instances of that lack
pagefault_disable() - might be a bug, need to check that.  powerpc and
sparc ones also lack it, but those have pagefault_disable() done in
caller.  tile ones open-code access_ok(), AFAICS.  Sorting that pile
out would already about half the amount of callers.

Ho-hum...  There's something odd about those - some of them seem to
assume that we are under set_fs(USER_DS), some do what access_ok()
would've done with USER_DS and proceed to __copy_from_user_inatomic().
And that includes the ones like sparc...  Very strange.

Am I right assuming that perf_callchain_user() can't be called other than
with USER_DS, but oprofile ->backtrace() can?  I'm not familiar enough
with oprofile guts...  Folks?
