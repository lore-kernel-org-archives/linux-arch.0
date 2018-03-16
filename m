From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: arc_usr_cmpxchg and preemption
Date: Fri, 16 Mar 2018 11:12:09 -0700
Message-ID: <CAMo8BfLLfiVO4yQLRtjz_KCNx-FTnPY-4wWQjHPrJeMgBf+DbQ@mail.gmail.com>
References: <1521045375.11552.27.camel@synopsys.com> <fdf30e76-f75d-9dda-26ca-ac011c41ee64@synopsys.com>
 <20180314175352.GP4064@hirez.programming.kicks-ass.net> <1521059931.11552.51.camel@synopsys.com>
 <20180315081845.GS4064@hirez.programming.kicks-ass.net> <1521105128.11552.64.camel@synopsys.com>
 <20180315112829.GW4064@hirez.programming.kicks-ass.net> <1521140611.6358.29.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521140611.6358.29.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

> On Thu, Mar 15, 2018 at 12:03 PM, Alexey Brodkin <Alexey.Brodkin@synopsys.com> wrote:
> Here's a brief analysis:
> ARM:  Looks like they got rid of that stuff in v4.4, see
>       commit db695c0509d6 ("ARM: remove user cmpxchg syscall").
>
> M68K: That's even uglier implementation which is really asking for
>       a facelift, look at sys_atomic_cmpxchg_32() here:
>       https://elixir.bootlin.com/linux/latest/source/arch/m68k/kernel/sys_m68k.c#L461
>
> MIPS: They do it via special sysmips syscall which among other things
>       might handle MIPS_ATOMIC_SET with mips_atomic_set()
>
> I don't immediately see if there're others but really I'm not sure if it even worth trying to
> clean-up all that since efforts might be spent pointlessly.

xtensa is another one. We used to have a buggy implementation in
arch/xtensa/kernel/entry.S:fast_syscall_xtensa which we still keep
disabled by default, just in case somebody wanted backwards
compatibility. I don't think it's worth fixing.

-- 
Thanks.
-- Max
