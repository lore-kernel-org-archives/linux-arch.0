From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86: faster strncpy_from_user()
Date: Tue, 10 Apr 2012 15:50:49 -0700
Message-ID: <CA+55aFwpX=SG6ECoi958+huLJ=egi3FDLxEeFpFtR8Hn8BJMDg@mail.gmail.com>
References: <CA+55aFy8J5Ns4P514g7Ow4WhJXO+pjPBozYuCinYB+FQUKjZ6A@mail.gmail.com>
 <1334097321.3040.62.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51408 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757013Ab2DJWvL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 18:51:11 -0400
Received: by wibhj6 with SMTP id hj6so3816320wib.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Apr 2012 15:51:09 -0700 (PDT)
In-Reply-To: <1334097321.3040.62.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, linux-arch@vger.kernel.org

On Tue, Apr 10, 2012 at 3:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Talking of which ... I haven't had much time to look but any reason that
> wouldn't work on BE platforms as well when they have a fast
> byteswap-load

No reason. Talk to Davem - I know he was looking at doing the whole
dcache-by-word thing on sparc.

Sparc has the added complication of doing slow unaligneds, though - I
think you might be in a better situation than that on ppc (at least
some of them).

> Now powerpc sadly only have up to 32-bit byteswap loads
> so doing 64-bit requires a bit of shifting around but the result might
> still be faster than loading individual bytes especially since we do
> have a bunch of registers to spare....

So one thing you might want to look into is to only do the byte-swap
*outside* the loop. You can do the "does it have zero or slash bytes"
inside the loop with the big-endian values, and then you can
re-compute it at the end with the byte-swapped one.  It's a few extra
ops, but it shouldn't be too bad.

Of course, for the actual dcache lookup, the loop count really does
tend to be just one or two, because you work one component at a time.
So you might  just want to do the byte swapping inside the loop, in
order to not have to re-do- the zero/slash detection afterwards.

For the "strncpy_from_user()", you only have the 'detect zeroes', and
the loop count is often noticeable (whole pathname), so it might make
sense to do that outside the loop.

> Maybe ?
>
> I might have a chance to actually test later today (chasing some
> regressions goes first)

Try it out. I used three different "benchmarks" for profiling:
 - the "stat() same file 10 million times" (to avoid cache misses)
 - the "make -j" on a fully build kernel (to see a "real load")
 - a "git diff" with "core.preloadindex=true" on a git repository that
is just a collection of 16 kernel trees side-by-side (it just does a
lot of 'lstat()' calls in parallell threads, and shows cache misses
but unlike "make" has almost zero actual user space costs)

The "stat ten million times" is the one that is worth most to test the
word-at-a-time things, because the "lots of files" cases really do
tend to do a lot of D$ misses, both on the dentry hash chains, the
inode accesses, and the security layer adds its own horribly
inode->i_security dereference.

                   Linus
