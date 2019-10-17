Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36205 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfJQHtk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Oct 2019 03:49:40 -0400
Received: by mail-oi1-f193.google.com with SMTP id k20so1360064oih.3
        for <linux-arch@vger.kernel.org>; Thu, 17 Oct 2019 00:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191016083959.186860-1-elver@google.com> <20191016083959.186860-2-elver@google.com>
 <20191016184346.GT2328@hirez.programming.kicks-ass.net> <CANpmjNP4b9Eo3ZKE6maBs4ANS7K7sLiVB2CbebQnCH09TB+hZQ@mail.gmail.com>
 <20191017074730.GW2328@hirez.programming.kicks-ass.net>
In-Reply-To: <20191017074730.GW2328@hirez.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Thu, 17 Oct 2019 09:49:27 +0200
Message-ID: <CANpmjNPKbCrL+XzmMrnjqw+EYOa2H94cgE5sPJeuVONbCSqBHg@mail.gmail.com>
Subject: Re: [PATCH 1/8] kcsan: Add Kernel Concurrency Sanitizer infrastructure
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Alexander Potapenko <glider@google.com>, Andrea Parri <parri.andrea@gmail.com>, Andrey Konovalov <andreyknvl@google.com>, Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Boqun Feng <boqun.feng@gmail.com>, Borislav Petkov <bp@alien8.de>, Daniel Axtens <dja@axtens.net>, Daniel Lustig <dlustig@nvidia.com>, dave.hansen@linux.intel.com, David Howells <dhowells@redhat.com>, Dmitry Vyukov <dvyukov@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@redhat.com>, Luc Maranget <luc.maranget@inria.fr>, Mark Rutland <mark.rutland@arm.com>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-efi@vger.kernel.org, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Memory Management List <linux-mm@kvack.org>, the arch/x86 maintainers <x86@kernel.org>
Message-ID: <20191017074927.tnEQ2RVezWoXBfq9NxBZUUsfWr6HQPCYwToxkXECfGg@z>

On Thu, 17 Oct 2019 at 09:47, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 16, 2019 at 09:34:05PM +0200, Marco Elver wrote:
> > On Wed, 16 Oct 2019 at 20:44, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > +     /*
> > > > +      * Disable interrupts & preemptions, to ignore races due to accesses in
> > > > +      * threads running on the same CPU.
> > > > +      */
> > > > +     local_irq_save(irq_flags);
> > > > +     preempt_disable();
> > >
> > > Is there a point to that preempt_disable() here?
> >
> > We want to avoid being preempted while the watchpoint is set up;
> > otherwise, we would report data-races for CPU-local data, which is
> > incorrect.
>
> Disabling IRQs already very much disables preemption. There is
> absolutely no point in doing preempt_disable() when the whole section
> already runs with IRQs disabled.

Ah thanks for the clarification, in that case I assume it's safe to
remove preempt_disable() for v2.

> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20191017074730.GW2328%40hirez.programming.kicks-ass.net.
