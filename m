From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Fri, 19 Aug 2016 22:24:28 +0100
Message-ID: <20160819212428.GR2356@ZenIV.linux.org.uk>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40118 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754127AbcHSVYc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2016 17:24:32 -0400
Content-Disposition: inline
In-Reply-To: <1471633802-2936-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>

On Fri, Aug 19, 2016 at 12:10:02PM -0700, Vineet Gupta wrote:
> Al reported potential issue with ARC get_user() as it wasn't clearing
> out destination pointer in case of fault due to bad address etc.

Applied to my branch with other similar fixes.  FWIW, there's another
interesting question in the same general area - __get_user() callers
tend to be on hot paths and they clump a _lot_.  That's the original
reasoning behind the __-variants; doing access_ok() once for the entire
bunch rather then repeating it for every single call.

However, access_ok() is not the only problem.  Testing if an error has
happened and conditional branching can also be sensitive; moreover,
on recent x86 SMAP-related setup/teardown is costly as hell.  The latter
problem is solved by bracketing the entire series of accesses with
a single setup/teardown pair (uaccess_begin()/uaccess_end()) and using
unsafe_get_user()/unsafe_put_user() between those.  The former has spawned
a bunch of solutions:

	* pretty much arch-independent optimization - use err |= __get_user()
instead of if (__get_user() != 0) goto fail.  We drop branching, but we
still get a plenty of crap.

	* x86-only get_user_ex().  Does *not* return anything, uses per-process
flag to indicate errors, the entire sequence is bracketed by uaccess_try()
and uaccess_catch(err), the latter dumps the flag into err.  Pairing of
brackets is enforced - expansion of uaccess_try() contains do { and
uaccess_catch() - } while (0).  Can't mix any userland access other than
{get,put}_user_ex/unsafe_{get,put}_user into the series - AC flag will be
buggered.  In particular, any use of __copy_{to,from}_user() is a bug there.

	* somewhat similar, __get_user_err(v, p, err) on assorted architectures
that are less register-starved than x86 is.  Those are equivalent to
	if (__get_user(v, p))
		err = -EFAULT;
and translate into something along the lines of
in .text:
	1: reg = *p;
	2: v = (__typeof(*p))reg;
in .text.fixup:
fixup(1): reg = 0; err = -EFAULT; goto 2;
That gives a branch-free path in the normal case, with fixups done out-of-line.
get_user_ex() is similar, except that it uses a field in current_thread_info()
where those use a local variable.  No bracketing needed - only access_ok()
before going there.

About a half of __get_user() callers are in arch/*, mostly in sigreturn(2)
and friends.  For those the use of arch-specific primitives is OK.  However,
there's another big pile in assorted compat code, and that obviously isn't
OK with arch-specific stuff.

I realize that asking such questions can very easily devolve into bikeshedding,
with a bunch of "only x86 matters anyway" thrown in, but... it would be
nice to come up with a syntax that could be used in arch-independent places.
I toyed with things like
	uaccess_begin();
	...
	get_user_ex(v, p, err);
	...
	put_user_ex(v, q, err);
	...
	copy_from_user_ex(&s, r, err);
	...
	copy_to_user_ex(&s, r, err);
	...
	copy_in_user_ex(t, r, err);
	...
	uaccess_check(err);
	...
	err |= sanity_check(...);	// returns 0 or -EFAULT
	...
	uaccess_end(err);
with x86 basically ignoring err in ..._ex() primitives and doing
err |= current_thread_info()->flag; in uaccess_end()/uaccess_check(), while
something that currently has __get_user_err() et.al. mapping get_user_ex()
to it and making uaccess_{begin,end,check} no-ops, but that's pretty much
a mechanical merge of those variants and none too pretty, at that.

Suggestions?
