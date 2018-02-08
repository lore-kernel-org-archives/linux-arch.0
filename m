From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] bug.h: Work around GCC PR82365 in BUG()
Date: Wed, 7 Feb 2018 16:51:35 -0800
Message-ID: <bee6cae0-6371-d185-dffb-ff7e9a4a8a1d@synopsys.com>
References: <20171219114112.939391-1-arnd@arndb.de>
 <8e42a1de-f619-7a4e-6d58-f90f53f5f38f@synopsys.com>
 <CAK8P3a2fXQHCN7gqNL9j7AeZqy7NXAMW1bqyFJs3G1M_M4BQ4A@mail.gmail.com>
 <f31caa9b-89f0-4168-04bf-14a98595865e@synopsys.com>
 <CAK8P3a25RgC0qPCrGfutSnLHr77NqK74dW2g0m7fcMnm5Ou8yg@mail.gmail.com>
 <27bfdc23-1774-cf07-dab4-ab253a41d2f7@synopsys.com>
 <CAK8P3a0UKLJkmU_zVDyODMZR0G47i=zscNpgGZO4LryvmdUt6Q@mail.gmail.com>
 <861992dd-a28d-0f8c-572f-4194d15238df@synopsys.com>
 <20180207160138.0705eeca67d8cc4d6309381c@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:33818 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbeBHAvw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Feb 2018 19:51:52 -0500
In-Reply-To: <20180207160138.0705eeca67d8cc4d6309381c@linux-foundation.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Christopher Li <sparse@chrisli.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, arcml <linux-snps-ar>

On 02/07/2018 04:01 PM, Andrew Morton wrote:
> On Wed, 20 Dec 2017 12:29:02 -0800 Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> 
>> On 12/20/2017 12:12 PM, Arnd Bergmann wrote:
>>>> Sorry, I didn't realize we are missing the stack trace now which you removed
>>>> from the patch - why ? Did u intend to reduce inline generated code for the
>>>> stack dump calls - which sounds like a great idea. But it would only work
>>>> for the synchronous abort() but not when builtin translates to actual trap
>>>> inducing instruction.
>>>
>>> I assumed that the trap instruction would trigger the register and
>>> stack dump, as it does on all other architectures.
>>
>> Only if __builtin_trap() translated to that instruction. Otherwise we need to do
>> this inside abort()
>>
>>> The most common
>>> way this is handled is to have one instruction that is known to trap,
>>> and use that to trigger a BUG(), and have __builtin_trap() issue
>>> that instruction as well.
>>
>> Good point. So we'll need ARC specific abort anyways.
>>
>>
>>> You might also want to implement CONFIG_DEBUG_BUGVERBOSE
>>> support to attach further data to it.
>>
>> OK I'll take a look !
>>
>>> How about overriding abort() with the same instruction that
>>> __builtin_trap() inserts on newer compilers then? That should
>>> make the behavior consistent.
>>
>> Yeah this is a great point ! Will do
> 
> Didn't do ;)

Actually I did :-)

The discussion above digressed from original intent of the patch and instead 
veered of into need for handling __builtin_trap() for ARC and a fallback abort() 
with same semantics etc which I'd agreed to do above. They are upstream

2017-12-08 af1be2e21203 ARC: handle gcc generated __builtin_trap for older compiler
2017-12-20 f5a16b93e629 ARC: handle gcc generated __builtin_trap()

However we missed this large stack issue and the -Werror=return-type warning for ARC.

Let me check the patch again and get back here !

> 
> Is Arnd's patch good to merge or do we need a fixup?
> 
> 
> From: Arnd Bergmann <arnd@arndb.de>
> Subject: bug.h: work around GCC PR82365 in BUG()
> 
> Looking at functions with large stack frames across all architectures led
> me discovering that BUG() suffers from the same problem as
> fortify_panic(), which I've added a workaround for already.  In short,
> variables that go out of scope by calling a noreturn function or
> __builtin_unreachable() keep using stack space in functions afterwards.
> 
> A workaround that was identified is to insert an empty assembler statement
> just before calling the function that doesn't return.  I'm adding a macro
> "barrier_before_unreachable()" to document this, and insert calls to that
> in all instances of BUG() that currently suffer from this problem.
> 
> The files that saw the largest change from this had these frame sizes
> before, and much less with my patch:
> 
> fs/ext4/inode.c:82:1: warning: the frame size of 1672 bytes is larger than 800 bytes [-Wframe-larger-than=]
> fs/ext4/namei.c:434:1: warning: the frame size of 904 bytes is larger than 800 bytes [-Wframe-larger-than=]

[...]

> In case of ARC and CRIS, it turns out that the BUG() implementation
> actually does return (or at least the compiler thinks it does), resulting
> in lots of warnings about uninitialized variable use and leaving noreturn
> functions, such as:
> 
> block/cfq-iosched.c: In function 'cfq_async_queue_prio':
> block/cfq-iosched.c:3804:1: error: control reaches end of non-void function [-Werror=return-type]
> include/linux/dmaengine.h: In function 'dma_maxpq':
> include/linux/dmaengine.h:1123:1: error: control reaches end of non-void function [-Werror=return-type]
> 
> This makes them call __builtin_trap() instead, which should normally dump
> the stack and kill the current process, like some of the other
> architectures already do.
> 
> I tried adding barrier_before_unreachable() to panic() and fortify_panic()
> as well, but that had very little effect, so I'm not submitting that
> patch.

[...]

> 
> diff -puN arch/arc/include/asm/bug.h~bugh-work-around-gcc-pr82365-in-bug arch/arc/include/asm/bug.h
> --- a/arch/arc/include/asm/bug.h~bugh-work-around-gcc-pr82365-in-bug
> +++ a/arch/arc/include/asm/bug.h
> @@ -23,7 +23,8 @@ void die(const char *str, struct pt_regs
>   
>   #define BUG()	do {								\
>   	pr_warn("BUG: failure at %s:%d/%s()!\n", __FILE__, __LINE__, __func__); \
> -	dump_stack();								\
> +	barrier_before_unreachable();						\
> +	__builtin_trap();							\
>   } while (0)

> 
