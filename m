Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43018 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755767AbdLTUMg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Dec 2017 15:12:36 -0500
MIME-Version: 1.0
In-Reply-To: <27bfdc23-1774-cf07-dab4-ab253a41d2f7@synopsys.com>
References: <20171219114112.939391-1-arnd@arndb.de> <8e42a1de-f619-7a4e-6d58-f90f53f5f38f@synopsys.com>
 <CAK8P3a2fXQHCN7gqNL9j7AeZqy7NXAMW1bqyFJs3G1M_M4BQ4A@mail.gmail.com>
 <f31caa9b-89f0-4168-04bf-14a98595865e@synopsys.com> <CAK8P3a25RgC0qPCrGfutSnLHr77NqK74dW2g0m7fcMnm5Ou8yg@mail.gmail.com>
 <27bfdc23-1774-cf07-dab4-ab253a41d2f7@synopsys.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 20 Dec 2017 21:12:34 +0100
Message-ID: <CAK8P3a0UKLJkmU_zVDyODMZR0G47i=zscNpgGZO4LryvmdUt6Q@mail.gmail.com>
Subject: Re: [PATCH] bug.h: Work around GCC PR82365 in BUG()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Christopher Li <sparse@chrisli.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, arcml <linux-snps-arc@lists.infradead.org>
Message-ID: <20171220201234.8x8j8GZM9H3SiECVAopG8memC7KD9XIbFp-4UjF_18k@z>

On Wed, Dec 20, 2017 at 7:52 PM, Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
> On 12/20/2017 01:01 AM, Arnd Bergmann wrote:
>>
>> On Tue, Dec 19, 2017 at 11:38 PM, Vineet Gupta
>> <Vineet.Gupta1@synopsys.com> wrote:
>>>
>>> On 12/19/2017 12:13 PM, Arnd Bergmann wrote:
>>>>
>>>>
>>>>
>>>>> I suppose BUG() implies "dead end" like semantics - which ARC was
>>>>> lacking
>>>>> before ?
>>>>
>>>>
>>>> Correct. Using __builtin_trap() here avoids the 'control reaches end of
>>>> non-void
>>>> function' warnings, but then makes us run into the stack size problem
>>>> that
>>>> I work around with the barrier_before_unreachable().
>>>>
>>>> It would be good if you could give this a quick test to see if you get
>>>> sensible
>>>> output from the __builtin_trap();
>>>
>>>
>>>
>>> It does, added a BUG() arbit, hits an abort()
>>>
>>> ...
>>> ISA Extn    : atomic ll64 unalign (not used)
>>>          : mpy[opt 9] div_rem norm barrel-shift swap minmax swape
>>> BPU        : partial match, cache:2048, Predict Table:16384
>>> BUG: failure at ../arch/arc/mm/tlb.c:827/arc_mmu_init()!
>>>
>>>
>>> Tested-by: Vineet Gupta <vgupta@synopsys.com>
>>
>>
>> I meant whether it prints the right registers and stack trace, but I
>> assume you tested that and just did not list it above.
>
>
> Sorry, I didn't realize we are missing the stack trace now which you removed
> from the patch - why ? Did u intend to reduce inline generated code for the
> stack dump calls - which sounds like a great idea. But it would only work
> for the synchronous abort() but not when builtin translates to actual trap
> inducing instruction.

I assumed that the trap instruction would trigger the register and
stack dump, as it does on all other architectures. The most common
way this is handled is to have one instruction that is known to trap,
and use that to trigger a BUG(), and have __builtin_trap() issue
that instruction as well.

You might also want to implement CONFIG_DEBUG_BUGVERBOSE
support to attach further data to it.

>> Hmm, so with the new definition of abort(),
>>
>> +__weak void abort(void)
>> +{
>> +   BUG();
>> +
>> +   /* if that doesn't kill us, halt */
>> +   panic("Oops failed to kill thread");
>> +}
>>
>> won't that run into an endless recursion? Or do you then override abort()
>> for ARC?
>
>
> Indeed so. I didn't run into this in my testing as my for-curr has an ARC
> specific version (predating Sudip's generic version- because of build
> failures in our internal regression jobs etc). That version only calls
> panic.
>
> abort() is only likely to be called due to __builtin_trap() for arches where
> gcc doesn't have a target specific defn of it. And thus adding the call from
> BUG() will cause the recursion as you found out with Sudip's generic version
> and thus needs a fixup.

How about overriding abort() with the same instruction that
__builtin_trap() inserts on newer compilers then? That should
make the behavior consistent.

        Arnd
