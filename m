From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 19:13:31 -0700
Message-ID: <CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
References: <20120525.191407.1171512018515372695.davem@davemloft.net>
 <CA+55aFxyno-mCNsJZzpW+5HAc0KA477ZeHGZ6=ONLcnHWiHaEA@mail.gmail.com>
 <20120525.194125.1593753424815090718.davem@davemloft.net> <20120525.204135.1619066165157180427.davem@davemloft.net>
 <CA+55aFwQV9kaVV9rvrVvqMa_dAetG-X1HzsiHHb4TNVa=W6Pgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38451 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab2EZCNy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 22:13:54 -0400
Received: by wibhn6 with SMTP id hn6so70226wib.1
        for <linux-arch@vger.kernel.org>; Fri, 25 May 2012 19:13:52 -0700 (PDT)
In-Reply-To: <CA+55aFwQV9kaVV9rvrVvqMa_dAetG-X1HzsiHHb4TNVa=W6Pgg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org

On Fri, May 25, 2012 at 6:09 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I can do that. Give me a few minutes. Or more. Let's see how it ends up..

Ugh. So this was not at all as trivial as I thought it would be.

One issue is just syntactic: the fact that you want to initialize
those constants just results in nasty syntax. Is gcc really so bad on
sparc that it doesn't do the obvious CSE etc on the constants? That
surprises me, because it does it on x86-64..

But the more annoying issue is that the dentry code really does depend
on the fact that we can just combine the masks for two values (the
zero bytes and the '/' bytes) and test and munge them together. And
that's simply not true of your big-endian version.

I think that instead of the "find_zero()" function, we need a
"generate_mask()" function that actually generates the reliable mask
of "these bytes have a bit set if the byte was zero". That's the

  unsigned long mask = (c & p->low_bits) + p->low_bits;
  mask = (mask | p->rhs);

phase of the big-endian logic (and would be a no-op on little endian).

So it looks like we'd really want to have three phases:

 - the "quick check if it has a zero" (and save that value away as the
preliminary mask)

   This is what the loop generates and tests end on, and could
(obviously) be or'ed together in the *test* to check two cases at the
same time.

      preliminary = has_zero(val);

 - the "reliable mask" that is generated from the quick mask and the last value

   This would be a "prep" function right after the loop exit, and it
could be or'ed together to have just one value for the final phase:

        reliable = prep_zero_mask(val, preliminary);

 - the find zero byte (and for some users, find "mask" that goes with
it) from the single value generated above.

        offset = find_zero(reliable);

But quite frankly, your three-value struct makes this much uglier than
I think it would need to be. That's *especially* true since the
constants should be shared, even if you have two different values
going on concurrently for the dentry case (the NUL and '/' values).

Because if I read the sparc code correctly, it really never needs more
than one single word at any time. The only reason you have that opaque
data structure is that the other two words are those constants that
you preload, and that really the compiler *should* be able to CSE just
fine. Do you *really* need to CSE them by hand?

I think we could get rid of that structure entirely, and just have
everybody use a single "unsigned long". If you just used the constants
directly in the code and could rely on the compiler. Hmm?

So how bad does the code look on sparc if you just get rid of the
"low_bits" and "high_bits" and just replace them with the constants
they are?

                        Linus
