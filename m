From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86: faster strncpy_from_user()
Date: Fri, 6 Apr 2012 14:49:17 -0700
Message-ID: <CA+55aFxiL_qm=a7qb2FiEojx81BOpmmNraN84zXh-vpFLwJSVA@mail.gmail.com>
References: <CA+55aFy8J5Ns4P514g7Ow4WhJXO+pjPBozYuCinYB+FQUKjZ6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57809 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab2DFVtj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Apr 2012 17:49:39 -0400
Received: by wgbdr13 with SMTP id dr13so2487340wgb.1
        for <linux-arch@vger.kernel.org>; Fri, 06 Apr 2012 14:49:38 -0700 (PDT)
In-Reply-To: <CA+55aFy8J5Ns4P514g7Ow4WhJXO+pjPBozYuCinYB+FQUKjZ6A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, linux-arch@vger.kernel.org

On Fri, Apr 6, 2012 at 2:32 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, this works for me on x86 (you need current tip-of-git for the
> <asm/word-at-a-time.h> thing) and is quite noticeable in profiles
> (well, if you have loads that do a lot of pathname lookups: I use a
> microbenchmarks that does ten million lookups of a filename with
> multiple components, but I also do "make -j" profiles of a fully build
> tree).

Some actual numbers: my microbenchmark used to take just over 9s
(best-of-six:9.053s) back before the dcache lookup optimizations

With some of the __d_lookup_rcu cleanups, and doing dentry_cmp() a
word at a time, that best-of-six dropped to 8.504s, and then
eventually with the full word-wide hashing it dropped to 8.013s. Some
more optimization got it consistently into the mid-sevens, which is
roughly where 3.4-rc1 was.

Today, my "best-of-six" numbers are 6.301s for that same binary, on
the same machine. Now, the numbers aren't hugely stable, and I didn't
do the same pre-population of the dcache that I did with the earlier
numbers, so it's not entirely comparable. But it's basically
approaching almost 30% better than the original code.

Admittedly just on a silly micro-benchmark, but still: all that
benchmark does is just "stat()" the same path over and over - which is
not a totally unrealistic thing to do. The "same path" means that it
doesn't show the cache effects as much (and the profiles are much
"sharper"). And while the "make -j" thing clearly shows different
profiles, the top five kernel functions have actually been pretty
consistent between the two cases, even if the details change.

Note: extra good numbers are with all my (uncommitted) selinux fixes
too, and there is a fair amounf of fluctuation in the numbers (lots
and lots of cache effects), but the strncpy change did make a
noticeable difference. Earlier today, I had a hard time getting the
number under 7s. Getting to 6.3 was partly strncpy, but about half of
it was my very experimental selinux stuff. Some of which might never
end up being committed, who knows..

                     Linus
