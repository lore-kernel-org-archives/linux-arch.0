From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v8 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
Date: Thu, 18 Aug 2016 17:12:11 +0200
Message-ID: <20160818151211.GN13300@pathway.suse.cz>
References: <1471377024-2244-1-git-send-email-cmetcalf@mellanox.com>
 <1471377024-2244-5-git-send-email-cmetcalf@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1471377024-2244-5-git-send-email-cmetcalf@mellanox.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Aaron Tomlin <atomlin@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue 2016-08-16 15:50:24, Chris Metcalf wrote:
> When doing an nmi backtrace of many cores, most of which are idle,
> the output is a little overwhelming and very uninformative.  Suppress
> messages for cpus that are idling when they are interrupted and just
> emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> 
> We do this by grouping all the cpuidle code together into a new
> .cpuidle.text section, and then checking the address of the
> interrupted PC to see if it lies within that section.
> 
> This commit suitably tags x86 and tile idle routines, and only
> adds in the minimal framework for other architectures.
> 
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index b77f5edb03b0..4429f80aabcf 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -1,6 +1,7 @@
>  #ifndef _X86_IRQFLAGS_H_
>  #define _X86_IRQFLAGS_H_
>  
> +#include <linux/compiler.h>
>  #include <asm/processor-flags.h>
>  
>  #ifndef __ASSEMBLY__
> @@ -44,12 +45,12 @@ static inline void native_irq_enable(void)
>  	asm volatile("sti": : :"memory");
>  }
>  
> -static inline void native_safe_halt(void)
> +static __always_inline void native_safe_halt(void)
>  {
>  	asm volatile("sti; hlt": : :"memory");
>  }

Ah, the __always_inline stuff did not helped here. It was
not inlined:

$> nm -n vmlinux | grep native_safe_halt
ffffffff81050bc0 t native_safe_halt

The reason seems to be that it is called via
PVOP_VCALL0(pv_irq_ops.safe_halt);, see below
in the disassembly.

I guess that it is because I have
CONFIG_PARAVIRT=y


void __cpuidle default_idle(void)
{
ffffffff819683f0:       e8 2b 2a 00 00          callq  ffffffff8196ae20 <__fentry__>
ffffffff819683f5:       55                      push   %rbp
ffffffff819683f6:       48 89 e5                mov    %rsp,%rbp
ffffffff819683f9:       41 54                   push   %r12
ffffffff819683fb:       53                      push   %rbx
        trace_cpu_idle_rcuidle(1, smp_processor_id());
ffffffff819683fc:       65 44 8b 25 0c 1d 6a    mov    %gs:0x7e6a1d0c(%rip),%r12d        # a110 <cpu_number>
ffffffff81968403:       7e 
ffffffff81968404:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
        safe_halt();
ffffffff81968409:       e8 a2 23 76 ff          callq  ffffffff810ca7b0 <trace_hardirqs_on>
}
#endif

static inline void arch_safe_halt(void)
{
        PVOP_VCALL0(pv_irq_ops.safe_halt);
ffffffff8196840e:       ff 14 25 80 a1 e2 81    callq  *0xffffffff81e2a180
        trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
ffffffff81968415:       65 44 8b 25 f3 1c 6a    mov    %gs:0x7e6a1cf3(%rip),%r12d        # a110 <cpu_number>
ffffffff8196841c:       7e 
ffffffff8196841d:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
}
ffffffff81968422:       5b                      pop    %rbx
ffffffff81968423:       41 5c                   pop    %r12
ffffffff81968425:       5d                      pop    %rbp
ffffffff81968426:       c3                      retq   
ffffffff81968427:       65 8b 05 e2 1c 6a 7e    mov    %gs:0x7e6a1ce2(%rip),%eax        # a110 <cpu_number>
ffffffff8196842e:       89 c0                   mov    %eax,%eax


Best Regards,
Petr
