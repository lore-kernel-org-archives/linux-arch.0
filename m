From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: arc_usr_cmpxchg and preemption
Date: Wed, 14 Mar 2018 09:58:19 -0700
Message-ID: <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
References: <1521045375.11552.27.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521045375.11552.27.camel@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

+CC linux-arch, Peter for any preemption insights !

On 03/14/2018 09:36 AM, Alexey Brodkin wrote:
> Hi Vineet,
> 
> While debugging a segfault of user-space app on system without atomic ops
> (I mean LLOCK/SCOND) I understood the root-cause is in implementation
> of kernel's __NR_arc_usr_cmpxchg syscall which is supposed to emulate mentioned
> atomic ops for user-space.
> 
> So here's a problem.
> 
> 1. User-space app [via libc] triggers __NR_arc_usr_cmpxchg syscall,
>     we enter arc_usr_cmpxchg()which basically does:
>     ---------------------------->8-------------------------------
>       preempt_disable();
>       __get_user(uval, uaddr);
>       __put_user(new, uaddr);
>       preempt_enable();
>     ---------------------------->8-------------------------------
> 
> 2. Most of the time everything is fine because __get_user()/__put_user()
>     for ARC is just LD/ST.
> 
> 3. Rarely user's variable is situated in not yet allocated page.
>     Here I mean copy-on-write case, when a page has read-only flag in TLB.
>     In that case __get_user() succeeds but __put_user() causes Privilege
>     Violation exception and we enter do_page_fault() where new page allocation
>     with proper access bits is supposed to happen... but that never happens
>     because with preempt_disable() we set in_atomic() which set
>     faulthandler_disabled() and so we exit early from page fault handler
>     effectively with nothing done, i.e. user's variable is left unchanged
>     which in its turn causes very strange problems later down the line because
>     we don't notify user-space app about failed data modification.

Interesting problem ! But what is special here, I would think syscalls in general 
could hit this.

> 
> The simplest fix is to not mess with preemption:
>     ---------------------------->8-------------------------------
> diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
> index 5ac3b547453f..d1713d8d3981 100644
> --- a/arch/arc/kernel/process.c
> +++ b/arch/arc/kernel/process.c
> @@ -63,8 +63,6 @@ SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
>          if (!access_ok(VERIFY_WRITE, uaddr, sizeof(int)))
>                  return -EFAULT;
>   
> -       preempt_disable();
> -
>          if (__get_user(uval, uaddr))
>                  goto done;

...
...

>   done:
> -       preempt_enable();
> -
>          return uval;
>   }
>     ---------------------------->8-------------------------------
> 
> But I'm not really sure how safe is that.

Well it is broken wrt the semantics the syscall is supposed to provide. Preemption 
disabling is what prevents a concurrent thread from coming in and modifying the 
same location (Imagine a variable which is being cmpxchg concurrently by 2 threads).

One approach is to do it the MIPS way, emulate the llsc flag - set it under 
preemption disabled section and clear it in switch_to

see arch/mips/kernel/syscall.c
