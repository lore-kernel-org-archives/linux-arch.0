Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43866 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfKNSFr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Nov 2019 13:05:47 -0500
Received: by mail-ot1-f68.google.com with SMTP id l14so5646427oti.10
        for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2019 10:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20191104142745.14722-1-elver@google.com> <20191104164717.GE20975@paulmck-ThinkPad-P72>
 <CANpmjNOtR6NEsXGo=M1o26d8vUyF7gwj=gew+LAeE_D+qfbEmQ@mail.gmail.com>
 <20191104194658.GK20975@paulmck-ThinkPad-P72> <CANpmjNPpVCRhgVgfaApZJCnMKHsGxVUno+o-Fe+7OYKmPvCboQ@mail.gmail.com>
 <20191105142035.GR20975@paulmck-ThinkPad-P72> <CANpmjNPEukbQtD5BGpHdxqMvnq7Uyqr9o3QCByjCKxtPboEJtA@mail.gmail.com>
In-Reply-To: <CANpmjNPEukbQtD5BGpHdxqMvnq7Uyqr9o3QCByjCKxtPboEJtA@mail.gmail.com>
From: Marco Elver <elver@google.com>
Date: Thu, 14 Nov 2019 19:05:34 +0100
Message-ID: <CANpmjNPTMjx4TSr+LEwV-xm8jFtATOym=h416j5rLK1V4kOYCg@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Add Kernel Concurrency Sanitizer (KCSAN)
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Mark Rutland <mark.rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20191114180534.8ZISpHvFMTeSXr_JDSk1TDOQruiBMLUU_Rsx2IctyYI@z>

On Tue, 5 Nov 2019 at 16:25, Marco Elver <elver@google.com> wrote:
>
> On Tue, 5 Nov 2019 at 15:20, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Tue, Nov 05, 2019 at 12:10:56PM +0100, Marco Elver wrote:
> > > On Mon, 4 Nov 2019 at 20:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Mon, Nov 04, 2019 at 07:41:30PM +0100, Marco Elver wrote:
> > > > > On Mon, 4 Nov 2019 at 17:47, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > >
> > > > > > On Mon, Nov 04, 2019 at 03:27:36PM +0100, Marco Elver wrote:
> > > > > > > This is the patch-series for the Kernel Concurrency Sanitizer (KCSAN).
> > > > > > > KCSAN is a sampling watchpoint-based data-race detector. More details
> > > > > > > are included in Documentation/dev-tools/kcsan.rst. This patch-series
> > > > > > > only enables KCSAN for x86, but we expect adding support for other
> > > > > > > architectures is relatively straightforward (we are aware of
> > > > > > > experimental ARM64 and POWER support).
> > > > > > >
> > > > > > > To gather early feedback, we announced KCSAN back in September, and
> > > > > > > have integrated the feedback where possible:
> > > > > > > http://lkml.kernel.org/r/CANpmjNPJ_bHjfLZCAPV23AXFfiPiyXXqqu72n6TgWzb2Gnu1eA@mail.gmail.com
> > > > > > >
> > > > > > > We want to point out and acknowledge the work surrounding the LKMM,
> > > > > > > including several articles that motivate why data-races are dangerous
> > > > > > > [1, 2], justifying a data-race detector such as KCSAN.
> > > > > > > [1] https://lwn.net/Articles/793253/
> > > > > > > [2] https://lwn.net/Articles/799218/
> > > > > > >
> > > > > > > The current list of known upstream fixes for data-races found by KCSAN
> > > > > > > can be found here:
> > > > > > > https://github.com/google/ktsan/wiki/KCSAN#upstream-fixes-of-data-races-found-by-kcsan
> > > > > >
> > > > > > Making this more accessible to more people seems like a good thing.
> > > > > > So, for the series:
> > > > > >
> > > > > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > > > >
> > > > > Much appreciated. Thanks, Paul!
> > > > >
> > > > > Any suggestions which tree this could eventually land in?
> > > >
> > > > I would guess that Dmitry might have some suggestions.
> > >
> > > I checked and we're both unclear what the most obvious tree to land in
> > > is (the other sanitizers are mm related, which KCSAN is not).
> > >
> > > One suggestion that comes to my mind is for KCSAN to go through the
> > > same tree (rcu?) as the LKMM due to their inherent relationship. Would
> > > that make most sense?
> >
> > It works for me, though you guys have to continue to be the main
> > developers.  ;-)
>
> Great, thanks. We did add an entry to MAINTAINERS, so yes of course. :-)
>
> > I will go through the patches more carefully, and please look into the
> > kbuild test robot complaint.
>
> I just responded to that, it seems to be a sparse problem.
>
> Thanks,
> -- Marco

v4 was sent out:
http://lkml.kernel.org/r/20191114180303.66955-1-elver@google.com

Thanks,
-- Marco
