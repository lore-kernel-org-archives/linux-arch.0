From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] spin loop primitives for busy waiting
Date: Sat, 13 May 2017 01:56:27 +1000
Message-ID: <20170513015627.36a19cc5@roar.ozlabs.ibm.com>
References: <20170511165727.17847-1-npiggin@gmail.com>
        <CA+55aFzS9ENQnRoTbLMd_nFwwjuU+s9yj0tZcLSYDDjnwqTKrg@mail.gmail.com>
        <063D6719AE5E284EB5DD2968C1650D6DCFFE9D65@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35455 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757522AbdELP4n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2017 11:56:43 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so7495454pfd.2
        for <linux-arch@vger.kernel.org>; Fri, 12 May 2017 08:56:43 -0700 (PDT)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFE9D65@AcuExch.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Linus Torvalds' <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>

On Fri, 12 May 2017 12:58:12 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Linus Torvalds
> > Sent: 11 May 2017 19:48  
> ...
> > The one question I have is about "spin_on_cond()": since you
> > explicitly document that the "no spinning" case is expected to be the
> > default, I really think that the default implementation should be
> > along the lines if
> > 
> >   #define spin_on_cond(cond) do { \
> >     if (unlikely(!(cond))) { \
> >         spin_begin(); do spin_cpu_relax(); while (!(cond)); spin_end(); \
> >     } \
> >   } while (0)
> > 
> > which will actually result in better code generation even if
> > spin_begin/end() are no-ops, and just generally optimizes for the
> > right behavior (ie do the spinning out-of-line, since by definition it
> > cannot be performance-critical after the first iteration).  
> 
> At least some versions of gcc convert while (cond) do {body}
> into if (cond) do {body} while (cond) even when 'cond'
> is a non-trivial expression and 'body' is trivial.
> The code-bloat is silly.
> No point enforcing the 'optimisation' here.

The point is for something like this:

static inline unsigned __read_seqcount_begin(const seqcount_t *s)
{
        unsigned ret;

repeat:
        ret = READ_ONCE(s->sequence);
        if (unlikely(ret & 1)) {
                cpu_relax();
                goto repeat;
        }
        return ret;
}

to be coded as:

static inline unsigned __read_seqcount_begin(const seqcount_t *s)
{
        unsigned ret;

	spin_on_cond( !((ret = READ_ONCE(s->sequence)) & 1) );

        return ret;
}

That's about as complex as you'd want to go with this, but I think
it's a reasonable case.

Now for x86, you would want these to fall out to the same code
generated. For powerpc, you do not want those spin_begin(); spin_end();

You are right there's a bit of code bloat there. It gets moved out
of line, but gcc still isn't all that smart about it though, and
it doesn't fold the tests back nicely if I go with Linus's suggestion,
so it doesn't work so well as generic implementation.

For powerpc we have to live with it I think.

Thanks,
Nick
