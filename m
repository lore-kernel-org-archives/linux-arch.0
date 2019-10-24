Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41094 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408021AbfJXRJ0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2019 13:09:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id 94so1409461oty.8
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2019 10:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191017141305.146193-1-elver@google.com> <20191017141305.146193-5-elver@google.com>
 <20191024122801.GD4300@lakrids.cambridge.arm.com> <CANpmjNPFkqOSEcEP475-NeeJnY5pZ44m+bEhtOs8E_xkRKr-TQ@mail.gmail.com>
 <20191024163545.GI4300@lakrids.cambridge.arm.com>
In-Reply-To: <20191024163545.GI4300@lakrids.cambridge.arm.com>
From: Marco Elver <elver@google.com>
Date: Thu, 24 Oct 2019 19:09:12 +0200
Message-ID: <CANpmjNOg8wK71_PnQ03UhsY0H212bXWj+4keT0dDK18F4UNPHw@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] seqlock, kcsan: Add annotations for KCSAN
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20191024170912.610Z81h1N7rY8p1e4pN0MX56v8630lYqD5QErII36ag@z>

On Thu, 24 Oct 2019 at 18:35, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Oct 24, 2019 at 04:17:11PM +0200, Marco Elver wrote:
> > On Thu, 24 Oct 2019 at 14:28, Mark Rutland <mark.rutland@arm.com> wrote:
> > >
> > > On Thu, Oct 17, 2019 at 04:13:01PM +0200, Marco Elver wrote:
> > > > Since seqlocks in the Linux kernel do not require the use of marked
> > > > atomic accesses in critical sections, we teach KCSAN to assume such
> > > > accesses are atomic. KCSAN currently also pretends that writes to
> > > > `sequence` are atomic, although currently plain writes are used (their
> > > > corresponding reads are READ_ONCE).
> > > >
> > > > Further, to avoid false positives in the absence of clear ending of a
> > > > seqlock reader critical section (only when using the raw interface),
> > > > KCSAN assumes a fixed number of accesses after start of a seqlock
> > > > critical section are atomic.
> > >
> > > Do we have many examples where there's not a clear end to a seqlock
> > > sequence? Or are there just a handful?
> > >
> > > If there aren't that many, I wonder if we can make it mandatory to have
> > > an explicit end, or to add some helper for those patterns so that we can
> > > reliably hook them.
> >
> > In an ideal world, all usage of seqlocks would be via seqlock_t, which
> > follows a somewhat saner usage, where we already do normal begin/end
> > markings -- with subtle exception to readers needing to be flat atomic
> > regions, e.g. because usage like this:
> > - fs/namespace.c:__legitimize_mnt - unbalanced read_seqretry
> > - fs/dcache.c:d_walk - unbalanced need_seqretry
> >
> > But anything directly accessing seqcount_t seems to be unpredictable.
> > Filtering for usage of read_seqcount_retry not following 'do { .. }
> > while (read_seqcount_retry(..));' (although even the ones in while
> > loops aren't necessarily predictable):
> >
> > $ git grep 'read_seqcount_retry' | grep -Ev 'seqlock.h|Doc|\* ' | grep
> > -v 'while ('
> > => about 1/3 of the total read_seqcount_retry usage.
> >
> > Just looking at fs/namei.c, I would conclude that it'd be a pretty
> > daunting task to prescribe and migrate to an interface that forces
> > clear begin/end.
> >
> > Which is why I concluded that for now, it is probably better to make
> > KCSAN play well with the existing code.
>
> Thanks for the detailed explanation, it's very helpful.
>
> That all sounds reasonable to me -- could you fold some of that into the
> commit message?

Thanks, will do. (I hope to have v3 ready by some time next week.)

-- Marco

> Thanks,
> Mark.
