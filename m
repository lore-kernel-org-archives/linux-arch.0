Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45436 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfJARo5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Oct 2019 13:44:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id y72so8529794pfb.12
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2019 10:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190830034304.24259-1-yamada.masahiro@socionext.com>
 <f5c221f5749e5768c9f0d909175a14910d349456.camel@suse.de> <CAKwvOdk=tr5nqq1CdZnUvRskaVqsUCP0SEciSGonzY5ayXsMXw@mail.gmail.com>
 <CAHk-=wiTy7hrA=LkmApBE9PQtri8qYsSOrf2zbms_crfjgR=Hw@mail.gmail.com>
 <20190930112636.vx2qxo4hdysvxibl@willie-the-truck> <CAK7LNASQZ82KSOrQW7+Wq1vFDCg2__maBEAPMLqUDqZMLuj1rA@mail.gmail.com>
 <20190930121803.n34i63scet2ec7ll@willie-the-truck> <CAKwvOdnqn=0LndrX+mUrtSAQqoT1JWRMOJCA5t3e=S=T7zkcCQ@mail.gmail.com>
 <20191001092823.z4zhlbwvtwnlotwc@willie-the-truck> <CAKwvOdk0h2A6=fb7Yepf+oKbZfq_tqwpGq8EBmHVu1j4mo-a-A@mail.gmail.com>
 <20191001170142.x66orounxuln7zs3@willie-the-truck>
In-Reply-To: <20191001170142.x66orounxuln7zs3@willie-the-truck>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 1 Oct 2019 10:44:43 -0700
Message-ID: <CAKwvOdnFJqipp+G5xLDRBcOrQRcvMQmn+n8fufWyzyt2QL_QkA@mail.gmail.com>
Subject: Re: [PATCH] compiler: enable CONFIG_OPTIMIZE_INLINING forcibly
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Stefan Wahren <wahrenst@gmx.net>, Kees Cook <keescook@google.com>
Message-ID: <20191001174443.AA1sUnbpXJYYGAYugDxo-RmzUCKFkTvBy1b_w55eRaw@z>

On Tue, Oct 1, 2019 at 10:01 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Oct 01, 2019 at 09:32:25AM -0700, Nick Desaulniers wrote:
> > On Tue, Oct 1, 2019 at 2:28 AM Will Deacon <will@kernel.org> wrote:
> > > On Mon, Sep 30, 2019 at 02:50:10PM -0700, Nick Desaulniers wrote:
> > > > In this case, if there's a known codegen bug in a particular compiler
> > > > or certain versions of it, I recommend the use of either the C
> > > > preprocessor or __attribute__((no_inline)) to get the desired behavior
> > > > localized to the function in question, and for us to proceed with
> > > > Masahiro's cleanup.
> > >
> > > Hmm, I don't see how that would help. The problem occurs when things
> > > are moved out of line by the compiler (see below).
> >
> > It's being moved out of line because __attribute__((always_inline)) or
> > just inline provide no guarantees that outlining does not occur.  It
> > would help to make functions that need to be inlined macros, because
> > the C preprocessor doesn't have that issue.
>
> Hmm, let me try to put it another way: enabling CONFIG_OPTIMIZE_INLINING
> has been shown to cause miscompilation with many versions of GCC on arm64
> because the compiler moves things out of line that it otherwise doesn't
> appear to do.

Yes.  That code should use the C preprocessor to force inlining. Then
you can enable CONFIG_OPTIMIZE_INLINING for arm64.

> I don't see how __attribute__((no_inline)) helps with that,

Because that *wasn't* the point of what I said about
__attribute__((no_inline)). My point is to use the C preprocessor to
guarantee that no outlining occurs.

My point related to __attribute__((no_inline)) was the simple decision
matrix that should be used:

Do I need strong guarantees that my code must be inlined? Use the C
preprocessor.
Do I need strong guarantees that my code is *not* to be inlined? Use
__attribute__((no_inline)).

The *former* is what applies here, not the latter.

inline and __attribute__((always_inline)) don't provide strong
guarantees (despite their fun sounding names;
-funsafe-math-optimizations/-Ofast being the poster child for "that
sounds nice, I would like my math to be fun, safe, and fast, let's use
that, WCGW?").  The more we use them, the more we continuously be
bitten by bugs related to outlining. Like the one you cited and the
arm32 patch Masahiro wrote.

Would using the C preprocessor to force inlining fix the GCC/arm64
miscompilation bug you described above? I suspect it would.

> and replacing static functions with macros isn't great for type-checking
> and argument evaluation.

See typecheck (include/linux/typecheck.h).

> > You don't have to convince compiler folks about correctness. ;)
> > Correctness trumps all, especially performance.
>
> Then why is this conversation so difficult? :(

I apologize; I don't mean to be difficult.  I would just like to avoid
surprises when code written with the assumption that it will be
inlined is not.  It sounds like we found one issue in arm32 and one in
arm64 related to outlining.  If we fix those two cases, I think we're
close to proceeding with Masahiro's cleanup, which I view as a good
thing for the health of the Linux kernel codebase.
-- 
Thanks,
~Nick Desaulniers
