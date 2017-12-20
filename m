From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] bug.h: Work around GCC PR82365 in BUG()
Date: Wed, 20 Dec 2017 10:52:27 -0800
Message-ID: <27bfdc23-1774-cf07-dab4-ab253a41d2f7@synopsys.com>
References: <20171219114112.939391-1-arnd@arndb.de>
 <8e42a1de-f619-7a4e-6d58-f90f53f5f38f@synopsys.com>
 <CAK8P3a2fXQHCN7gqNL9j7AeZqy7NXAMW1bqyFJs3G1M_M4BQ4A@mail.gmail.com>
 <f31caa9b-89f0-4168-04bf-14a98595865e@synopsys.com>
 <CAK8P3a25RgC0qPCrGfutSnLHr77NqK74dW2g0m7fcMnm5Ou8yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a25RgC0qPCrGfutSnLHr77NqK74dW2g0m7fcMnm5Ou8yg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Christopher Li <sparse@chrisli.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>arcml <l>
List-Id: linux-arch.vger.kernel.org

On 12/20/2017 01:01 AM, Arnd Bergmann wrote:
> On Tue, Dec 19, 2017 at 11:38 PM, Vineet Gupta
> <Vineet.Gupta1@synopsys.com> wrote:
>> On 12/19/2017 12:13 PM, Arnd Bergmann wrote:
>>>
>>>
>>>> I suppose BUG() implies "dead end" like semantics - which ARC was lacking
>>>> before ?
>>>
>>> Correct. Using __builtin_trap() here avoids the 'control reaches end of
>>> non-void
>>> function' warnings, but then makes us run into the stack size problem that
>>> I work around with the barrier_before_unreachable().
>>>
>>> It would be good if you could give this a quick test to see if you get
>>> sensible
>>> output from the __builtin_trap();
>>
>>
>> It does, added a BUG() arbit, hits an abort()
>>
>> ...
>> ISA Extn    : atomic ll64 unalign (not used)
>>          : mpy[opt 9] div_rem norm barrel-shift swap minmax swape
>> BPU        : partial match, cache:2048, Predict Table:16384
>> BUG: failure at ../arch/arc/mm/tlb.c:827/arc_mmu_init()!
>>
>>
>> Tested-by: Vineet Gupta <vgupta@synopsys.com>
> 
> I meant whether it prints the right registers and stack trace, but I
> assume you tested that and just did not list it above.

Sorry, I didn't realize we are missing the stack trace now which you removed from 
the patch - why ? Did u intend to reduce inline generated code for the stack dump 
calls - which sounds like a great idea. But it would only work for the synchronous 
abort() but not when builtin translates to actual trap inducing instruction.

> Hmm, so with the new definition of abort(),
> 
> +__weak void abort(void)
> +{
> +   BUG();
> +
> +   /* if that doesn't kill us, halt */
> +   panic("Oops failed to kill thread");
> +}
> 
> won't that run into an endless recursion? Or do you then override abort()
> for ARC?

Indeed so. I didn't run into this in my testing as my for-curr has an ARC specific 
version (predating Sudip's generic version- because of build failures in our 
internal regression jobs etc). That version only calls panic.

abort() is only likely to be called due to __builtin_trap() for arches where gcc 
doesn't have a target specific defn of it. And thus adding the call from BUG() 
will cause the recursion as you found out with Sudip's generic version and thus 
needs a fixup.


Thx,
-Vineet
