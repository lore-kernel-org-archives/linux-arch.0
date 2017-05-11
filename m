From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] spin loop primitives for busy waiting
Date: Thu, 11 May 2017 11:47:47 -0700
Message-ID: <CA+55aFzS9ENQnRoTbLMd_nFwwjuU+s9yj0tZcLSYDDjnwqTKrg@mail.gmail.com>
References: <20170511165727.17847-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:38289 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752376AbdEKSrt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2017 14:47:49 -0400
Received: by mail-it0-f51.google.com with SMTP id e65so25251212ita.1
        for <linux-arch@vger.kernel.org>; Thu, 11 May 2017 11:47:49 -0700 (PDT)
In-Reply-To: <20170511165727.17847-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>

On Thu, May 11, 2017 at 9:57 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> If you find this acceptable, I'd like to start wiring in the powerpc
> and adding the annotations to some important core spin loops (there's
> not too many really). I'm hoping if you take this patch during this
> merge window, I'll be able to start sending small patches to maintainers
> for the next window. Unless you have a better suggestion for how to
> deal with this.

This looks fine to me as an interface, and yes, I guess I can just
take this scaffolding as-is.

The one question I have is about "spin_on_cond()": since you
explicitly document that the "no spinning" case is expected to be the
default, I really think that the default implementation should be
along the lines if

  #define spin_on_cond(cond) do { \
    if (unlikely(!(cond))) { \
        spin_begin(); do spin_cpu_relax(); while (!(cond)); spin_end(); \
    } \
  } while (0)

which will actually result in better code generation even if
spin_begin/end() are no-ops, and just generally optimizes for the
right behavior (ie do the spinning out-of-line, since by definition it
cannot be performance-critical after the first iteration).

So it's better even when you don't really have the begin/end overhead,
but that version of "spin_on_cond()" is then likely to work _much_
better if you actually do have it, when your version would seem to be
entirely unacceptable.

Hmm?

In fact, do you even want to make that "spin_on_cond()" version
conditional? I don't see how an architecture can really improve on it.
If an architecture wants to use things like "wait on this particular
variable", then that generic "cond" version is too generic an
interface anyway.

                  Linus
