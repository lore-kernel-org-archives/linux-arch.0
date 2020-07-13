From: Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
Date: Mon, 13 Jul 2020 08:48:16 -0700
Message-ID: <CALCETrUHsYp0oGAiy3N-yAauPyx2nKqp1AiETgSJWc77GwO-Sg@mail.gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-5-npiggin@gmail.com>
 <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
 <1594613902.1wzayj0p15.astroid@bobo.none> <1594647408.wmrazhwjzb.astroid@bobo.none>
 <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Andy Lutomirski <luto@kernel.org>, Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 13, 2020 at 7:13 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wrote:
>
> > Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
> >> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
> >>> Also, as it stands, I can easily see in_irq() ceasing to promise to
> >>> serialize.  There are older kernels for which it does not promise to
> >>> serialize.  And I have plans to make it stop serializing in the
> >>> nearish future.
> >>
> >> You mean x86's return from interrupt? Sounds fun... you'll konw where to
> >> update the membarrier sync code, at least :)
> >
> > Oh, I should actually say Mathieu recently clarified a return from
> > interrupt doesn't fundamentally need to serialize in order to support
> > membarrier sync core.
>
> Clarification to your statement:
>
> Return from interrupt to kernel code does not need to be context serializing
> as long as kernel serializes before returning to user-space.
>
> However, return from interrupt to user-space needs to be context serializing.
>

Indeed, and I figured this out on the first read through because I'm
quite familiar with the x86 entry code.  But Nick somehow missed this,
and Nick is the one who wrote the patch.

Nick, I think this helps prove my point.  The code you're submitting
may well be correct, but it's unmaintainable.  At the very least, this
needs a comment explaining, from the perspective of x86, *exactly*
what exit_lazy_tlb() is promising, why it's promising it, how it
achieves that promise, and what code cares about it.  Or we could do
something with TIF flags and make this all less magical, although that
will probably end up very slightly slower.

--Andy
