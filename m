Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:57592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfE2J61 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 05:58:27 -0400
Date: Wed, 29 May 2019 11:58:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] tools/objtool: add kasan_check_* to uaccess whitelist
Message-ID: <20190529095815.GL2623@hirez.programming.kicks-ass.net>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-2-elver@google.com>
 <20190528171942.GV2623@hirez.programming.kicks-ass.net>
 <CACT4Y+ZK5i0r0GSZUOBGGOE0bzumNor1d89W8fvphF6EDqKqHg@mail.gmail.com>
 <CANpmjNP7nNO36p03_1fksx1O2-MNevHzF7revUwQ3b7+RR0y+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP7nNO36p03_1fksx1O2-MNevHzF7revUwQ3b7+RR0y+w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20190529095815.ABT5K8X7jk9WL1CHUG2ggh6dprh0N4QCqlCllFsLtPg@z>

On Wed, May 29, 2019 at 11:46:10AM +0200, Marco Elver wrote:
> On Wed, 29 May 2019 at 10:55, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Tue, May 28, 2019 at 7:19 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, May 28, 2019 at 06:32:57PM +0200, Marco Elver wrote:
> > > > This is a pre-requisite for enabling bitops instrumentation. Some bitops
> > > > may safely be used with instrumentation in uaccess regions.
> > > >
> > > > For example, on x86, `test_bit` is used to test a CPU-feature in a
> > > > uaccess region:   arch/x86/ia32/ia32_signal.c:361
> > >
> > > That one can easily be moved out of the uaccess region. Any else?
> >
> > Marco, try to update config with "make allyesconfig" and then build
> > the kernel without this change.
> >
> 
> Done. The only instance of the uaccess warning is still in
> arch/x86/ia32/ia32_signal.c.
> 
> Change the patch to move this access instead? Let me know what you prefer.

Yes, I think that might be best. The whitelist should be minimal.
