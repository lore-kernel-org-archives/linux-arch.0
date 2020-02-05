From: Octavian Purdila <tavi.purdila@gmail.com>
Subject: Re: [RFC v3 01/26] asm-generic: atomic64: allow using generic
 atomic64 on 64bit platforms
Date: Wed, 5 Feb 2020 14:24:38 +0200
Message-ID: <CAMoF9u3Jhqyvp3SpA3mUqPhS4zDuXP9GCUu_XsYx2etE0KGkcQ@mail.gmail.com>
References: <cover.1580882335.git.thehajime@gmail.com> <39e1313ff3cf3eab6ceb5ae322fcd3e5d4432167.1580882335.git.thehajime@gmail.com>
 <20200205093454.GG14879@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44127 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBEMYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 07:24:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so2071953ljj.11
        for <linux-arch@vger.kernel.org>; Wed, 05 Feb 2020 04:24:50 -0800 (PST)
In-Reply-To: <20200205093454.GG14879@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Hajime Tazaki <thehajime@gmail.com>, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>

On Wed, Feb 5, 2020 at 11:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Feb 05, 2020 at 04:30:10PM +0900, Hajime Tazaki wrote:
> > From: Octavian Purdila <tavi.purdila@gmail.com>
> >
> > With CONFIG_64BIT enabled, atomic64 via CONFIG_GENERIC_ATOMIC64 options
> > are not compiled due to type conflict of atomic64_t defined in
> > linux/type.h.
> >
> > This commit fixes the issue and allow using generic atomic64 ops.
> >
> > Currently, LKL is only the user which defines GENERIC_ATOMIC64
> > (lib/atomic64.c) under CONFIG_64BIT environment.  Thus, there is no
> > issues before this commit.
>
> Uhhhhh, no.
>
> Not allowing GENERIC_ATOMIC64 on 64BIT is a *feature*.
>
> Any 64bit arch that needs GENERIC_ATOMIC64 is an utter piece of crap.
>
> Please explain more.
>

Hi Peter,

I was not aware that not allowing GENERIC_ATOMIC64 was intentional. I
understand your point that a 64 bit architecture that can't handle 64
bit atomic operation is broken.

One way to deal with this in LKL would be to use GCC atomic builtins
or if that doesn't work expose them as host operations. This would
keep LKL as a meta-arch that can run on multiple physical
architectures. I'll give it a try.
