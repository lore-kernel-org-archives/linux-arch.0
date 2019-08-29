Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40420 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfH2G6i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Aug 2019 02:58:38 -0400
Date: Thu, 29 Aug 2019 07:57:29 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH v2 3/3] arm: Add support for function error injection
Message-ID: <20190829065729.GU13294@shell.armlinux.org.uk>
References: <20190806100015.11256-1-leo.yan@linaro.org>
 <20190806100015.11256-4-leo.yan@linaro.org>
 <20190819091808.GB5599@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819091808.GB5599@leoy-ThinkPad-X240s>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Leo Yan <leo.yan@linaro.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, clang-built-linux@googlegroups.com, Masami Hiramatsu <mhiramat@kernel.org>
Message-ID: <20190829065729.o7Qw-aPsZMAz7ebEgGWecCcHPMrBEG6sQNd839Eje3I@z>

I'm sorry, I can't apply this, it produces loads of:

include/linux/error-injection.h:7:10: fatal error: asm/error-injection.h: No such file or directory

Since your patch 1 has been merged by the ARM64 people, I can't take
it until next cycle.

On Mon, Aug 19, 2019 at 05:18:08PM +0800, Leo Yan wrote:
> Hi Russell,
> 
> On Tue, Aug 06, 2019 at 06:00:15PM +0800, Leo Yan wrote:
> > This patch implements arm specific functions regs_set_return_value() and
> > override_function_with_return() to support function error injection.
> > 
> > In the exception flow, it updates pt_regs::ARM_pc with pt_regs::ARM_lr
> > so can override the probed function return.
> 
> Gentle ping ...  Could you review this patch?
> 
> Thanks,
> Leo.
> 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  arch/arm/Kconfig              |  1 +
> >  arch/arm/include/asm/ptrace.h |  5 +++++
> >  arch/arm/lib/Makefile         |  2 ++
> >  arch/arm/lib/error-inject.c   | 19 +++++++++++++++++++
> >  4 files changed, 27 insertions(+)
> >  create mode 100644 arch/arm/lib/error-inject.c
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 33b00579beff..2d3d44a037f6 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -77,6 +77,7 @@ config ARM
> >  	select HAVE_EXIT_THREAD
> >  	select HAVE_FAST_GUP if ARM_LPAE
> >  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> > +	select HAVE_FUNCTION_ERROR_INJECTION if !THUMB2_KERNEL
> >  	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL && !CC_IS_CLANG
> >  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> >  	select HAVE_GCC_PLUGINS
> > diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
> > index 91d6b7856be4..3b41f37b361a 100644
> > --- a/arch/arm/include/asm/ptrace.h
> > +++ b/arch/arm/include/asm/ptrace.h
> > @@ -89,6 +89,11 @@ static inline long regs_return_value(struct pt_regs *regs)
> >  	return regs->ARM_r0;
> >  }
> >  
> > +static inline void regs_set_return_value(struct pt_regs *regs, unsigned long rc)
> > +{
> > +	regs->ARM_r0 = rc;
> > +}
> > +
> >  #define instruction_pointer(regs)	(regs)->ARM_pc
> >  
> >  #ifdef CONFIG_THUMB2_KERNEL
> > diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> > index b25c54585048..8f56484a7156 100644
> > --- a/arch/arm/lib/Makefile
> > +++ b/arch/arm/lib/Makefile
> > @@ -42,3 +42,5 @@ ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
> >    CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
> >    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
> >  endif
> > +
> > +obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> > diff --git a/arch/arm/lib/error-inject.c b/arch/arm/lib/error-inject.c
> > new file mode 100644
> > index 000000000000..2d696dc94893
> > --- /dev/null
> > +++ b/arch/arm/lib/error-inject.c
> > @@ -0,0 +1,19 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/error-injection.h>
> > +#include <linux/kprobes.h>
> > +
> > +void override_function_with_return(struct pt_regs *regs)
> > +{
> > +	/*
> > +	 * 'regs' represents the state on entry of a predefined function in
> > +	 * the kernel/module and which is captured on a kprobe.
> > +	 *
> > +	 * 'regs->ARM_lr' contains the the link register for the probed
> > +	 * function, when kprobe returns back from exception it will override
> > +	 * the end of probed function and directly return to the predefined
> > +	 * function's caller.
> > +	 */
> > +	instruction_pointer_set(regs, regs->ARM_lr);
> > +}
> > +NOKPROBE_SYMBOL(override_function_with_return);
> > -- 
> > 2.17.1
> > 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
