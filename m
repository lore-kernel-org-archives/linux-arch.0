From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] bug.h: Work around GCC PR82365 in BUG()
Date: Wed, 7 Feb 2018 17:20:38 -0800
Message-ID: <e35cd0ea-b1b1-b8a1-6d01-6a17da091407@synopsys.com>
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
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20180207160138.0705eeca67d8cc4d6309381c@linux-foundation.org>
Content-Language: en-US
Sender: linux-kbuild-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Christopher Li <sparse@chrisli.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will.deacon@arm.com>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, arcml <linux-snps-ar>
List-Id: linux-arch.vger.kernel.org

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
> fs/ext4/super.c:2279:1: warning: the frame size of 1160 bytes is larger than 800 bytes [-Wframe-larger-than=]
> fs/ext4/xattr.c:146:1: warning: the frame size of 1168 bytes is larger than 800 bytes [-Wframe-larger-than=]
> fs/f2fs/inode.c:152:1: warning: the frame size of 1424 bytes is larger than 800 bytes [-Wframe-larger-than=]
> net/netfilter/ipvs/ip_vs_core.c:1195:1: warning: the frame size of 1068 bytes is larger than 800 bytes [-Wframe-larger-than=]
> net/netfilter/ipvs/ip_vs_core.c:395:1: warning: the frame size of 1084 bytes is larger than 800 bytes [-Wframe-larger-than=]
> net/netfilter/ipvs/ip_vs_ftp.c:298:1: warning: the frame size of 928 bytes is larger than 800 bytes [-Wframe-larger-than=]
> net/netfilter/ipvs/ip_vs_ftp.c:418:1: warning: the frame size of 908 bytes is larger than 800 bytes [-Wframe-larger-than=]
> net/netfilter/ipvs/ip_vs_lblcr.c:718:1: warning: the frame size of 960 bytes is larger than 800 bytes [-Wframe-larger-than=]
> drivers/net/xen-netback/netback.c:1500:1: warning: the frame size of 1088 bytes is larger than 800 bytes [-Wframe-larger-than=]
> 
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
> 
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82365
> Link: http://lkml.kernel.org/r/20171219114112.939391-1-arnd@arndb.de
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Christopher Li <sparse@chrisli.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>   arch/arc/include/asm/bug.h            |    3 ++-
>   arch/cris/include/arch-v10/arch/bug.h |   11 +++++++++--
>   arch/ia64/include/asm/bug.h           |    6 +++++-
>   arch/m68k/include/asm/bug.h           |    3 +++
>   arch/sparc/include/asm/bug.h          |    6 +++++-
>   include/asm-generic/bug.h             |    1 +
>   include/linux/compiler-gcc.h          |   15 ++++++++++++++-
>   include/linux/compiler.h              |    5 +++++
>   8 files changed, 44 insertions(+), 6 deletions(-)
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

For ARC, it is double win.

1. Fixes 3 -Wreturn-type warnings

| ../net/core/ethtool.c:311:1: warning: control reaches end of non-void function 
[-Wreturn-type]
| ../kernel/sched/core.c:3246:1: warning: control reaches end of non-void function 
[-Wreturn-type]
| ../include/linux/sunrpc/svc_xprt.h:180:1: warning: control reaches end of 
non-void function [-Wreturn-type]

2. bloat-o-meter reports code size improvements as gcc elides the generated code 
for stack return.


Acked-by: Vineet Gupta <vgupta@synopsys.com>   # for arch/arc
Tested-by: Vineet Gupta <vgupta@synopsys.com>   # for arch/arc
