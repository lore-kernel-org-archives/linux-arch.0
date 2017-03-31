From: Kees Cook <keescook@chromium.org>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 17:21:32 -0700
Message-ID: <CAGXu5j+R1gNpuUv1=795t7PGwyLznVCGrRovy5ZXb69SmA0NJA@mail.gmail.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35763 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934356AbdCaAVf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 20:21:35 -0400
Received: by mail-io0-f182.google.com with SMTP id z13so30469356iof.2
        for <linux-arch@vger.kernel.org>; Thu, 30 Mar 2017 17:21:34 -0700 (PDT)
In-Reply-To: <20170329055706.GH29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@sout>

On Tue, Mar 28, 2017 at 10:57 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>         We have several primitives for bulk kernel<->userland copying.
> That stuff lives in various asm/uaccess.h, with serious code duplication
> _and_ seriously inconsistent semantics.
>
>         That code has grown a lot of cruft and more than a few bugs.
> Some got caught and fixed last year, but some fairly unpleasant ones
> still remain.  A large part of problem was that a lot of code used to
> include <asm/uaccess.h> directly, so we had no single place to work
> with.  That got finally fixed in 4.10-rc1, when everything had been
> forcibly switched to including <linux/uaccess.h>.  At that point it
> became possible to start getting rid of boilerplate; I hoped to deal
> with that by 4.11-rc1, but the things didn't work out and that work
> has slipped to this cycle.
>
>         The patchset currently in vfs.git#work.uaccess is the result;
> there's more work to do, but it takes care of a large part of the
> problems.  About 2.8KLoc removed, a lot of cruft is gone and semantics
> is hopefully in sync now.  All but two architectures (ia64 and metag)
> had been switched to new mechanism; for these two I'm afraid that I'll
> need serious help from maintainers.

FWIW, I tested this on x86 and ARM with the LKDTM tests I built for
CONFIG_HARDENED_USERCOPY and this branch (which includes the earlier
fixes I suggested privately) tests fine for me.

>         Currently we have 8 primitives - 6 on every architecture and 2 more
> on biarch ones.  All of them have the same calling conventions: arguments
> are the same as for memcpy() (void *to, const void *from, unsigned long size)
> and the same rules for return value.
>         If all loads and stores succeed, everything is obvious - the
> 'size' bytes starting at 'to' become equal to 'size' bytes starting at 'from'
> and zero is returned.  If some loads or stores fail, non-zero value should
> be returned.  If any of those primitives returns a positive value N,
>         * N should be no greater than size
>         * the values fetched out of from[0..size-N-1] should be stored into the
> corresponding bytes of to[0..size-N-1]
>         * N should not be equal to size unless not a single byte could have
> been fetched or stored.  As long as that restriction is satisfied, these
> primitives are not required to squeeze every possible byte in case some
> loads or stores fail.
>
>         1) copy_from_user() - 'to' points to kernel memory, 'from' is
> normally a userland pointer.  This is used for copying structures from
> [...]
>         8) __copy_in_user().  Basically, copy_in_user() sans access_ok().
> Biarch-only, with the grand total of 6 callers...

It seems to me like everything above here should end up in comments
for these functions. I think even after the unification, it's valuable
to have this actually in the source.

>         What this series does is:
>
> * convert architectures to fewer primitives (raw_copy_{to,from,in}_user(),
> the last one only on biarch ones), switching to generic implementations
> of the 8 primitives aboves via raw_... ones.  Those generic implementations
> are in linux/uaccess.h (and lib/usercopy.c).  Architecture provides
> raw_... ones, selects ARCH_HAS_RAW_COPY_USER and it's done.

Bikeshed: I still prefer that the "raw_copy_*" functions be named
"arch_copy_*" or "__arch_copy_*" to match all the other arch-specific
functions in the kernel. This clearly marks them as arch-specific, and
in theory, the leading "__" would indicate that they're "internal" or
hint that they don't perform any of the checking done from the
standard interface functions.

Currently arm64 already uses the name __arch_copy_*, and arm's is
arm_copy_*. I just don't think "raw" is meaningful enough to avoid
people accidentally using it.

> * all object size check, kasan, etc. instrumentation is taken care of
> in linux/uaccess.h; no need to touch it in arch/*
>
> * consistent semantics wrt zero-padding - none of the raw_... do any of
> that, copy_from_user() does (outside of fast path).
>
> At the moment I have that conversion done for everything except ia64 and
> metag.  Once everything is converted, I'll remove ARCH_HAS_RAW_COPY_USER
> and make generic stuff unconditional; at the same point
> HAVE_ARCH_HARDENED_USERCOPY will be gone (becoming unconditionally true).

Yay! :)

> The series lives in git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
> in #work.uaccess.  It's based at 4.11-rc1.  Infrastructure is in
> #uaccess.stem, then it splits into per-architecture branches (uaccess.<arch>),
> eventually merged into #work.uaccess.  Some stuff (including a cherry-picked
> mips build fix) is in #uaccess.misc, also merged into the final.
>
> I hope that infrastructure part is stable enough to put it into never-rebased
> state.  Some of per-architecture branches might be even done right; however,
> most of them got no testing whatsoever, so any help with testing (as well
> as "Al, for fuck sake, dump that garbage of yours, here's the correct patch"
> from maintainers) would be very welcome.  So would the review, of course.
>
> In particular, the fix in uaccess.parisc should be replaced with the stuff
> Helge posted on parisc list, probably along with the get_user/put_user
> patches.  I've put my variant of fix there as a stopgap; switch of pa_memcpy()
> to assembler is clearly the right way to solve it and I'll be happy to
> switch to that as soon as parisc folks settle on the final version of that
> stuff.
>
> For most of the oddball architectures I have no way to test that stuff, so
> please treat the asm-affecting patches in there as a starting point for
> doing it right.  Some might even work as is - stranger things had happened,
> but don't count ont it.
>
> And again, metag and ia64 parts are simply not there - both architectures
> zero-pad in __copy_from_user_inatomic() and that really needs fixing.
> In case of metag there's __copy_to_user() breakage as well, AFAICS, and
> I've been unable to find any documentation describing the architecture
> wrt exceptions, and that part is apparently fairly weird.  In case of
> ia64...  I can test mckinley side of things, but not the generic __copy_user()
> and ia64 is about as weird as it gets.  With no reliable emulator, at that...
> So these two are up to respective maintainers.

I would also call out lib/test_user_copy.c (CONFIG_TEST_USER_COPY) for
maintainers to see if things are working correctly. This tries to test
all the size-specific combinations of possible copies and checks for
zeroing, etc. (I'm sure the test could be improved, but it's already
caught tiny bugs in per-arch implementations in the past.)

> Other things not there:
>         * unification of strncpy_from_user() and friends.  Probably next
> cycle.
>         * anything to do with uaccess_begin/unsafe accesses/uaccess_end
> stuff.  Definitely next cycle.
>
> I'm not sure if mailbombing linux-arch would be a good idea; there are
> 90 patches in that pile, with total size nearly half a megabyte.  If anyone
> wants that posted, I'll do so, but it might be more convenient to just
> use git.
>
> Comments, review, testing, replacement patches, etc. are very welcome.
>
>                                 Al "hates assembers, dozens of them" Viro
>
>
> [1]  Nick Piggin has spotted that bug back in early 2000s, fixed it for
> i386 and hadn't bothered to do anything about other architectures (including
> amd64, for crying out loud!).  Since then we had inconsistent behaviour
> between the architectures.  Results of those bugs range from transient bogus
> values observed in mmap() if you get memory pressure combined with bad timing
> to outright fs corruption, if the timing is *really* bad.  All architectures
> used to have it, hopefully this series will take care of the last stragglers.

Thanks for working on this! I've wanted to see this done for a long
time; I'm glad you had the time for it!

-Kees

-- 
Kees Cook
Pixel Security
