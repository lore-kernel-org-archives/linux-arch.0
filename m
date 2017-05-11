From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] spin loop primitives for busy waiting
Date: Fri, 12 May 2017 05:26:35 +1000
Message-ID: <20170512052613.55817b1a@roar.ozlabs.ibm.com>
References: <20170511165727.17847-1-npiggin@gmail.com>
        <CA+55aFzS9ENQnRoTbLMd_nFwwjuU+s9yj0tZcLSYDDjnwqTKrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34374 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932518AbdEKT0w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2017 15:26:52 -0400
Received: by mail-pf0-f193.google.com with SMTP id w69so4295718pfk.1
        for <linux-arch@vger.kernel.org>; Thu, 11 May 2017 12:26:52 -0700 (PDT)
In-Reply-To: <CA+55aFzS9ENQnRoTbLMd_nFwwjuU+s9yj0tZcLSYDDjnwqTKrg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>

On Thu, 11 May 2017 11:47:47 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, May 11, 2017 at 9:57 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > If you find this acceptable, I'd like to start wiring in the powerpc
> > and adding the annotations to some important core spin loops (there's
> > not too many really). I'm hoping if you take this patch during this
> > merge window, I'll be able to start sending small patches to maintainers
> > for the next window. Unless you have a better suggestion for how to
> > deal with this.  
> 
> This looks fine to me as an interface, and yes, I guess I can just
> take this scaffolding as-is.
> 
> The one question I have is about "spin_on_cond()": since you
> explicitly document that the "no spinning" case is expected to be the
> default, I really think that the default implementation should be
> along the lines if
> 
>   #define spin_on_cond(cond) do { \
>     if (unlikely(!(cond))) { \
>         spin_begin(); do spin_cpu_relax(); while (!(cond)); spin_end(); \
>     } \
>   } while (0)
> 
> which will actually result in better code generation even if
> spin_begin/end() are no-ops, and just generally optimizes for the
> right behavior (ie do the spinning out-of-line, since by definition it
> cannot be performance-critical after the first iteration).
> 
> So it's better even when you don't really have the begin/end overhead,
> but that version of "spin_on_cond()" is then likely to work _much_
> better if you actually do have it, when your version would seem to be
> entirely unacceptable.
> 
> Hmm?

I agree completely. But might it depend on architecture and so
just be something they could do themselves?

> In fact, do you even want to make that "spin_on_cond()" version
> conditional? I don't see how an architecture can really improve on it.
> If an architecture wants to use things like "wait on this particular
> variable", then that generic "cond" version is too generic an
> interface anyway.

So what I want is to be able to have architectures control the entire
loop, and you can do some interesting things with goto labels and
coding branches how you want them.

That was my motivation for doing the previous weird spin_do {} spin_while()
interface. But since you didn't like it, and I realized that kind of
control probably only matters for a very small subset of spin loops
(e.g., bit spinlock/seqlock, some idle loops in the scheduler, etc. that
do just tend to spin on a quite simple condition).

For example, if you sent the branch prediction to statically predict
the loop exits, then instead of taking a branch miss the first thing
you do when your lock gets freed, you will be doing useful instructions.

I haven't verified and done enough analysis yet to know if that's going
to be worthwhile yet, but I thought for some of those simple spins, it's
a nicer interface than the begin/relax/end.

Thanks,
Nick
