Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfJAKkv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Oct 2019 06:40:51 -0400
Date: Tue, 1 Oct 2019 11:40:44 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Message-ID: <20191001104043.cmgpa2lztwdwi35m@willie-the-truck>
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de>
 <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck>
 <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck>
 <CAK7LNAT8vx=vEwaj2=JYHzCYa_J68-TSmjN+sHZeaQYyWV95yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAT8vx=vEwaj2=JYHzCYa_J68-TSmjN+sHZeaQYyWV95yw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Nick Desaulniers <ndesaulniers@google.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>
Message-ID: <20191001104044._DkV4lUlGzkOIfc1iqI04JL9f3SsOOY8he9YRuoitlM@z>

On Tue, Oct 01, 2019 at 06:39:34PM +0900, Masahiro Yamada wrote:
> On Mon, Sep 30, 2019 at 9:18 PM Will Deacon <will@kernel.org> wrote:
> > I agree that the ARM code looks dodgy with
> > that call to uaccess_save_and_enable(), but there are __asmeq macros
> > in there to try to catch that, so it's still very fishy.
> 
> I am totally fine with double-checking
> the output from the compiler.

Sure, but don't you find it odd that those checks didn't fire, and instead
the failure occurred at runtime?

> > > I fixed it already. See
> > > https://lore.kernel.org/patchwork/patch/1132459/
> >
> > You fixed the specific case above for 32-bit ARM, but the arm64 case
> > is due to a compiler bug. As it happens, we've reworked our atomics
> > in 5.4 so that particular issue no longer triggers, but the fact remains
> > that GCC has been shown to screw up explicit register allocation for
> > perfectly legitimate code when giving the flexibility to move code out
> > of line.
> >
> > > The problems are fixable by writing correct code.
> >
> > Right, in the compiler ;)
> 
> Not always.
> 
> You showed a compiler bug case for arm64.
> The 32bit ARM is not the case.

I would be /very/ surprised if the same compiler bug didn't also apply
to ARM, which is why I'm championing the conservative approach of restoring
the old default behaviour rather than run the risk of runtime failures.

> > If it helps, here is more information about the arm64 failure which
> > triggered the GCC bugzilla:
> >
> > https://www.spinics.net/lists/arm-kernel/msg730329.html
> >
> You put multiple references here and there,
> but they are all about arch_atomic64_dec_if_positive().

Right, but that's because it was the atomic64 selftest code which triggered
the compiler bug in practice. Without a better understanding of why GCC
got this wrong, we can't assume that no other register variables are
affected.

Will
